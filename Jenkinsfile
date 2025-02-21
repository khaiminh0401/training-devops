pipeline {
    agent any

    environment {
        IMAGE_NAME = "angular-app"
        CONTAINER_NAME = "nginx"
        POD_NAME = "cicd-pod"
        NGINX_PATH = "/usr/share/nginx/html"
    }

    stages {
        stage('Clone Code') {
            steps {
                git 'https://github.com/user/repo.git'  // Thay Git repo của bạn
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "podman build -t ${IMAGE_NAME} ."
            }
        }

        stage('Deploy to Nginx in Pod') {
            steps {
                // Lấy ID của container Nginx trong pod
                script {
                    def nginxContainerId = sh(script: "podman ps --filter name=${CONTAINER_NAME} --format '{{.ID}}'", returnStdout: true).trim()
                    
                    if (nginxContainerId) {
                        sh "podman cp dist/. ${nginxContainerId}:${NGINX_PATH}/"
                    } else {
                        error "Nginx container not found in pod!"
                    }
                }
            }
        }
    }
}
