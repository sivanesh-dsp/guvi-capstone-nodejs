pipeline {
    agent any
    // parameters {
    //     string(name: 'DEPLOY_IP', description: 'IP address for deployment')
    // }
    environment {
        // Declare dockerImage variable globally so it can be accessed in multiple stages
        dockerImage = ''
        DEPLOY_IP = 'ip-172-31-7-142'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/sivanesh-dsp/guvi-capstone-nodejs.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build('sivaneshdsp/capstone-guvi')
                }
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Running tests..."'
                // Add real test commands later
            }
        }
        stage('Push Docker Image to GitHub Packages') {
            steps {
                script {
                    
                    // Log in to GitHub Packages using Docker
                    withCredentials([string(credentialsId: 'dockerhub-token', variable: 'TOKEN')]) {
                        sh 'docker login  -u sivaneshdsp -p $TOKEN'
                        
                        // Tag the Docker image with GitHub Packages URL
                        dockerImage.tag("latest")
                        
                        // Push the Docker image to GitHub Packages
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['ssh-key']) {
                    sh '''
                    scp -o StrictHostKeyChecking=no docker-compose.yml ubuntu@${DEPLOY_IP}:/home/ubuntu/
                    ssh -o StrictHostKeyChecking=no ubuntu@${DEPLOY_IP} "sudo docker compose -f /home/ubuntu/docker-compose.yml up -d"
                    '''
                }
            }
        }
    }
}
