pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                //sh 'docker build -t docker.pkg.github.com/yisu12/hello-pyhton/hello-python:v1 .'
                //sh 'docker push docker.pkg.github.com/yisu12/hello-pyhton/hello-python:v1'
                echo 'Build'
            }
        }
        stage('Package') {
            steps {
                withCredentials([string(credentialsId: 'github-token', variable: 'CR_PAT')]) {
                    sh 'echo $CR_PAT | docker login ghcr.io -u yisu12 --password-stdin'
                    
                    echo 'docker-compose up...'
                }
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['ssh-amazon']) {
                    //El withCredentials ya realiza el ssh-add ~/.ssh/clave-lucatic.pem
                    sh 'ssh -o "StrictHostKeyChecking no" ec2-user@63.33.189.210 docker pull docker.pkg.github.com/yisu12/hello-pyhton/hello-python:v1'
                    sh 'docker run --rm -p80:80 -d docker.pkg.github.com/yisu12/hello-pyhton/hello-python:v1'
                }
                echo 'Deploy'
            }
        }
    }
}
