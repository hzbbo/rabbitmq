pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/hzbboyour/rabbitmq.git'
            }
        }
        
        stage('Build Image') {
           environment {
                       registryCredential = 'harbor'
                    }
            steps {
                script {
                    sh "docker login 192.168.100.12 -u admin -p Unipoint11"
                    sh "docker push 192.168.100.12/sellers-utils/rabbitmq:v1.$BUILD_NUMBER
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    sh "docker build --no-cache -f Dockerfile -t 192.168.100.12/sellers-utils/rabbitmq:v1.$BUILD_NUMBER ."
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                         sh "/usr/local/bin/kubectl --kubeconfig=/home/jenkins/acloud-client.conf apply -f rabbitmq.yaml"
                         sh "/usr/local/bin/kubectl --kubeconfig=/home/jenkins/acloud-client.conf set image -n sellers-utills deployment/rabbitmq rabbitmq=192.168.100.12/sellers-utills/rabbitmq:v1.$BUILD_NUMBER"
                }
            }
        }
    }
}
