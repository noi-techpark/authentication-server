pipeline {
    agent any

    environment {
        DOCKER_PROJECT_NAME = "authentication-server"
        DOCKER_IMAGE = "authentication-server"
        DOCKER_TAG = "$BUILD_NUMBER"
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
                """
            }
        }
        stage('Assets') {
            steps {
                sh '''
                    docker build --pull --build-arg JENKINS_USER_ID=$(id -u jenkins) --build-arg JENKINS_GROUP_ID=$(id -g jenkins) -t ${DOCKER_PROJECT_NAME}-node:${BUILD_NUMBER} infrastructure/docker/node
                    docker run --rm -v $PWD:/code -w /code/themes/noi/common/resources ${DOCKER_PROJECT_NAME}-node:${BUILD_NUMBER} npm install
                    docker run --rm -v $PWD:/code -w /code/themes/noi/common/resources ${DOCKER_PROJECT_NAME}-node:${BUILD_NUMBER} npm run build
                '''
            }
        }
        stage('Build Keycloak extensions') {
            steps {
                sh'''
                    docker build --pull --build-arg JENKINS_USER_ID=$(id -u jenkins) --build-arg JENKINS_GROUP_ID=$(id -g jenkins) -t ${DOCKER_PROJECT_NAME}-maven:${BUILD_NUMBER} infrastructure/docker/maven
                    docker run --rm -v $PWD:/code -w /registration-event-listener ${DOCKER_PROJECT_NAME}-maven:${BUILD_NUMBER} mvn -B -U clean install
                '''
            }
        }
        stage('Build') {
            steps {
                sh "docker-compose -f infrastructure/docker-compose.build.yml build"
            }
        }
    }
    post {
        always {
            sh 'docker image rm -f ${DOCKER_PROJECT_NAME}-node:${BUILD_NUMBER}'
        }
    }
}
