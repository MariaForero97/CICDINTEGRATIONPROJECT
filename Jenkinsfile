pipeline {
    agent any

    environment {
        DOCKER_USER = "maria97"
        IMAGE_NAME = "python-ci-app"
        DOCKER_REGISTRY = "https://index.docker.io/v1/"
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Build Docker') {
            steps {
                script {
                    docker.build("${DOCKER_USER}/${IMAGE_NAME}:latest", "app/")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("${DOCKER_REGISTRY}", 'credenciales-docker') {
                        docker.image("${DOCKER_USER}/${IMAGE_NAME}:latest").push()
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { fileExists('terraform/main.tf') }
            }
            steps {
                dir('terraform') {
                bat '''
                terraform init
                terraform apply -auto-approve
                '''
                }
            }
        }

    }
}
