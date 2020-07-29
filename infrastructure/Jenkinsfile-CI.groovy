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
                sh 'docker run --no-ansi --rm -v $PWD:/code -w /code/themes/noi/common/resources -u $(id -u jenkins):$(id -g jenkins) node:12 npm install'
                sh 'docker run --no-ansi --rm -v $PWD:/code -w /code/themes/noi/common/resources -u $(id -u jenkins):$(id -g jenkins) node:12 npm run build'
            }
        }
        stage('Build') {
            steps {
                sh "docker-compose -f infrastrucutre/docker-compose.build.yml build"
            }
        }
    }
}
