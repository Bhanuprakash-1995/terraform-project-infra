pipeline {
    agent {
        node {
            label 'AGENT-1'
        }
    }
     options {
        timeout(time: 1, unit: 'HOURS') 
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    // build
    stages {       
        stage('VPC') {
            steps {
                sh """
                    cd 01-vpc
                    terraform init -reconfigure
                    terraform apply -auto-approve
                """
            }
        }
        stage('SG') {
            steps {
                sh """
                    cd 02-sg
                    terraform init -reconfigure
                    terraform apply -auto-approve
                """
            }
        }
        stage('VPN') {
            steps {
                sh """
                    cd 03-vpn
                    terraform init -reconfigure
                    terraform apply -auto-approve
                """
            }
        }
        stage('DB ALB') {
            parallel {
                stage('DB') {
                    steps {
                        sh """
                            cd 04-databases
                            terraform init -reconfigure
                            terraform apply -auto-approve
                            """ 
                    }
                }
                stage('AP-ALB') {
                    steps {
                        sh """
                            cd 05-app-alb
                            terraform init -reconfigure
                            terraform apply -auto-approve
                        """ 
                    }
                }
            }
        }
    }
    // post build
    post { 
        always { 
            echo 'I will always get executed irrespective of the pipeline status!'
            deleteDir()
        }
        failure { 
            echo 'This runs when pipeline is failed, used to send some alerts using slack..etc'
        }
        success { 
            echo 'This runs when pipeline executed successfully!'
        }
        aborted { 
            echo 'This runs when pipeline Timeout has been exceeded!'
        }
    }
}