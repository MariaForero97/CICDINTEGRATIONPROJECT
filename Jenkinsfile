pipeline {
    agent any

    environment {
        IMAGE_NAME = "cicdintegration"
        DOCKER_REGISTRY = "docker.io/maria97"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/MariaForero97/CICDINTEGRATIONPROJECT.git'
            }
        }

        stage('Build Docker') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:latest")
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

        stage('Terraform Init & Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy Infra - S3 Bucket') {
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
