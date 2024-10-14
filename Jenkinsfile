pipeline {
agent any
stages {
stage('Clone Repository') {
steps {
git 'https://github.com/yourusername/nodejs-app.git'
}
}
stage('Build Docker Image') {
steps {
script {
docker.build('nodejs-app')
}
}
}
stage('Test') {
steps {
sh 'echo "Running tests..."'
// Add real test commands later
}
}
stage('Deploy') {
steps {
sshagent(['your-ssh-key-id']) {
sh '''
scp -o StrictHostKeyChecking=no docker-compose.yml ubuntu@your-
ec2-ip:/home/ubuntu/
ssh -o StrictHostKeyChecking=no ubuntu@your-ec2-ip "docker-
compose -f /home/ubuntu/docker-compose.yml up -d"
'''
}
}
}
}
}
