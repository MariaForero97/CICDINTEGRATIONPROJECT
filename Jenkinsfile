pipeline {
    agent any

    environment {
        IMAGE_NAME = "python-ci-app"
        DOCKER_REGISTRY = "docker.io/maria97"
    }

    stages {

        stage('Build Docker') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:latest", "app/")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://${DOCKER_REGISTRY}", 'credenciales-docker') {
                        docker.image("${IMAGE_NAME}:latest").push()
                    }
                }
            }
        }

        stage('Terraform Apply (opcional)') {
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
