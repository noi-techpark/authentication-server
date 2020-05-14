pipeline {
    agent any

    environment {
        ENVIRONMENT = 'test'

        DOCKER_PROJECT_NAME = 'authentication-server'
        DOCKER_IMAGE = '755952719952.dkr.ecr.eu-west-1.amazonaws.com/authentication-server'
        DOCKER_TAG = "${ENVIRONMENT}-${BUILD_NUMBER}"

        DB_ADDR = 'test-pg-bdp.co90ybcr8iim.eu-west-1.rds.amazonaws.com'
        DB_PORT = '5432'
        DB_DATABASE = 'authentication_server'
        DB_USER = 'authentication_server'
        DB_PASSWORD = credentials("authentication-server-${ENVIRONMENT}-db-password")

        FRONTEND_URL = 'https://auth.opendatahub.testingmachine.eu/auth'
        ADMIN_NAME = 'admin'
        ADMIN_PASSWORD = credentials("authentication-server-${ENVIRONMENT}-admin-password")
    }

    stages {
        stage('Configure') {
            steps {
                sh """
                    rm -f .env
                    cp .env.example .env
                    echo 'COMPOSE_PROJECT_NAME=${DOCKER_PROJECT_NAME}' >> .env
                    echo 'DOCKER_IMAGE=${DOCKER_IMAGE}' >> .env
                    echo 'DOCKER_TAG=${DOCKER_TAG}' >> .env

                    echo 'DB_ADDR=${DB_ADDR}' >> .env
                    echo 'DB_PORT=${DB_PORT}' >> .env
                    echo 'DB_DATABASE=${DB_DATABASE}' >> .env
                    echo 'DB_USER=${DB_USER}' >> .env
                    echo 'DB_PASSWORD=${DB_PASSWORD}' >> .env

                    echo 'FRONTEND_URL=${FRONTEND_URL}' >> .env
                    echo 'ADMIN_NAME=${ADMIN_NAME}' >> .env
                    echo 'ADMIN_PASSWORD=${ADMIN_PASSWORD}' >> .env

                    rm -rf ansible/hosts
                    cp ansible/hosts_${ENVIRONMENT} ansible/hosts

                    rm -rf terraform/config
                    cp -R terraform/${ENVIRONMENT} terraform/config
                """
            }
        }
        stage('Assets') {
            steps {
                sh '''
                    docker run --rm -v $PWD:/code -w /code/themes/noi/common/resources node:12 npm install
                    docker run --rm -v $PWD:/code -w /code/themes/noi/common/resources node:12 npm run build
                '''
            }
        }
        stage('Build') {
            steps {
                sh '''
                    aws ecr get-login --region eu-west-1 --no-include-email | bash
                    docker-compose --no-ansi -f docker-compose.build.yml build --pull
                    docker-compose --no-ansi -f docker-compose.build.yml push
                '''
            }
        }
        stage('Deploy') {
            steps {
               sshagent(['jenkins-ssh-key']) {
                    sh """
                        (cd terraform && terraform init)
                        ansible-galaxy install --force -r ansible/requirements.yml

                        (cd terraform && terraform apply -auto-approve config/group-one)
                        ansible-playbook --limit=grouptwo ansible/deploy.yml --extra-vars "release_name=${BUILD_NUMBER}"

                        (cd terraform && terraform apply -auto-approve config/all)
                        sleep 30

                        (cd terraform && terraform apply -auto-approve config/group-two)
                        ansible-playbook --limit=groupone ansible/deploy.yml --extra-vars "release_name=${BUILD_NUMBER}"

                        (cd terraform && terraform apply -auto-approve config/all)
                        sleep 30
                    """
                }
            }
        }
    }
}
