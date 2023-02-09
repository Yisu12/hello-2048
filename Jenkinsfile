pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker-compose build'
                sh 'git tag 1.0.${BUILD_NUMBER}'
                sh 'docker tag ghcr.io/yisu12/hello-2048:latest ghcr.io/yisu12/hello-2048:1.0.${BUILD_NUMBER}'
                sshagent(['git2']) {
                    sh 'git push --tags'
                }
            }
        }
        stage('Package') {
            steps {
                withCredentials([string(credentialsId: 'github-token', variable: 'CR_PAT')]) {
                    sshagent(['git2']){
                        sh 'echo $CR_PAT | docker login ghcr.io -u yisu12 --password-stdin'
                        sh 'docker-compose push'
                        //sh 'docker push docker.pkg.github.com/yisu12/hello-2048/hello-2048:{BUILD_NUMBER}'
                        sh "docker push ghcr.io/yisu12/hello-2048:1.0.${BUILD_NUMBER}"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['ssh-amazon']) {
                    sh 'ssh -o "StrictHostKeyChecking no" ec2-user@63.33.189.210 docker pull ghcr.io/yisu12/hello-2048:1.0.${BUILD_NUMBER}'
                    sh 'ssh -o "StrictHostKeyChecking no" ec2-user@63.33.189.210 docker-compose up -d'
                }
                echo 'Deploy'
            }
        }
    }
}
