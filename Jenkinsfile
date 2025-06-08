pipeline {
    agent any
    
    environment {
        DOCKER_USER = "maria97"
        IMAGE_NAME = "python-ci-app"
        DOCKER_REGISTRY = "docker.io"
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
                    docker.withRegistry("https://${DOCKER_REGISTRY}", 'credenciales-docker') {
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
                    sh '''
                    terraform init
                    terraform apply -auto-approve
                    '''
                }
            }
        }
    }
}
