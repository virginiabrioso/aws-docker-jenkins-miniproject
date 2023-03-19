pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
              sh "docker build . -t todo-node-app"
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker run -d --name todo-node-app -p 8000:8000 todo-node-app'
            }
        }
    }
}