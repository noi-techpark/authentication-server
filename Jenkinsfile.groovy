pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        DOCKER_PROJECT_NAME = "authentication-server"
        DOCKER_IMAGE = "755952719952.dkr.ecr.eu-west-1.amazonaws.com/authentication-server"
        DOCKER_TAG = "$BUILD_NUMBER"
    }

    stages {
        stage('Configure') {
            steps {
                sh "echo '' > .env"
                sh "echo 'COMPOSE_PROJECT_NAME=${DOCKER_PROJECT_NAME}' >> .env"
                sh "echo 'DOCKER_IMAGE=${DOCKER_IMAGE}' >> .env"
                sh "echo 'DOCKER_TAG=${DOCKER_TAG}' >> .env"
            }
        }
        stage('Assets') {
            steps {
                sh 'docker run --rm -v $PWD:/code -w /code/themes/noi/common/resources node:12 npm install'
                sh 'docker run --rm -v $PWD:/code -w /code/themes/noi/common/resources node:12 npm run build'
            }
        }
        stage('Build & Push') {
            steps {
                sh "aws ecr get-login --region eu-west-1 --no-include-email | bash"
                sh "docker-compose -f docker-compose.build.yml build"
                sh "docker-compose -f docker-compose.build.yml push"
            }
        }
    }
}
