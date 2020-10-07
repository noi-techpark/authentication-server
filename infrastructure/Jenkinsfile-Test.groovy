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

                    rm -rf infrastructure/ansible/hosts
                    cp infrastructure/ansible/hosts_${ENVIRONMENT} infrastructure/ansible/hosts

                    rm -rf infrastructure/terraform/config
                    cp -R infrastructure/terraform/${ENVIRONMENT} infrastructure/terraform/config
                """
            }
        }
        stage('Assets') {
            steps {
                sh '''
                    docker build --pull --build-arg JENKINS_USER_ID=$(id -u jenkins) --build-arg JENKINS_GROUP_ID=$(id -g jenkins) -t ${DOCKER_IMAGE}-node:${BUILD_NUMBER} infrastructure/docker/node
                    docker run --rm -v $PWD:/code -w /code/themes/noi/common/resources ${DOCKER_IMAGE}-node:${BUILD_NUMBER} npm install
                    docker run --rm -v $PWD:/code -w /code/themes/noi/common/resources ${DOCKER_IMAGE}-node:${BUILD_NUMBER} npm run build
                '''
            }
        }
        stage('Build') {
            steps {
                sh '''
                    aws ecr get-login --region eu-west-1 --no-include-email | bash
                    docker-compose --no-ansi -f infrastructure/docker-compose.build.yml build --pull
                    docker-compose --no-ansi -f infrastructure/docker-compose.build.yml push
                '''
            }
        }
        stage('Deploy') {
            steps {
            //    sshagent(['jenkins-ssh-key']) {
            //         sh """
            //             (cd infrastructure/terraform && terraform init)
            //             (cd infrastructure/ansible && ansible-galaxy install --force -r requirements.yml)

            //             (cd infrastructure/terraform && terraform apply -auto-approve -var-file="config/main.tfvars" -var-file="config/groupone.tfvars")
            //             (cd infrastructure/ansible && ansible-playbook --limit=grouptwo deploy.yml --extra-vars "release_name=${BUILD_NUMBER}")

            //             (cd infrastructure/terraform && terraform apply -auto-approve -var-file="config/main.tfvars" -var-file="config/all.tfvars")
            //             sleep 30

            //             (cd infrastructure/terraform && terraform apply -auto-approve -var-file="config/main.tfvars" -var-file="config/grouptwo.tfvars")
            //             (cd infrastructure/ansible && ansible-playbook --limit=groupone deploy.yml --extra-vars "release_name=${BUILD_NUMBER}")

            //             (cd infrastructure/terraform && terraform apply -auto-approve -var-file="config/main.tfvars" -var-file="config/all.tfvars")
            //             sleep 30
            //         """
            //     }
                sshagent(['jenkins-ssh-key']) {
                    sh """
                        (cd infrastructure/ansible && ansible-galaxy install --force -r requirements.yml)

                        (cd infrastructure/ansible && ansible-playbook --limit=grouptwo deploy.yml --extra-vars "release_name=${BUILD_NUMBER}")

                        (cd infrastructure/ansible && ansible-playbook --limit=groupone deploy.yml --extra-vars "release_name=${BUILD_NUMBER}")
                    """
                }
            }
        }
    }
    post {
        always {
            sh 'docker image rm -f ${DOCKER_IMAGE}-node:${BUILD_NUMBER}'
        }
    }
}
