pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
              echo 'Update submodule'
              sh "git submodule update --init"
            }
        }
        stage('Build') {
            steps {
              echo 'Building todo-node-app docker image'
              sh "docker build . -t todo-node-app"
            }
        }
        stage('Deploy') {
            steps {
                sh (script: 'docker rm --force todo-node-app', returnStatus: true)
                sh 'docker run -d --name todo-node-app -p 8000:8000 todo-node-app'
            }
        }
    }
}