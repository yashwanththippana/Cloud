pipeline {

    agent none   // we will define agents per stage

    parameters {
        choice(
            name: 'SERVICE',
            choices: ['sns', 'ecs', 'alb', 'cloudmap', 'secretsmanager', 'ecr', 'autoscaling', 'cloudwatch', 'inspector'],
            description: 'Select which AWS service to provision'
        )
    }

    environment {
        AWS_REGION = "us-east-1"
    }

    stages {

        stage('Checkout') {
            agent any
            steps {
                checkout scm
            }
        }

        stage('Verify AWS Auth') {
            agent {
                any {
                    image 'amazon/aws-cli:2.17.0'
                    args '-u root:root'
                }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh 'aws sts get-caller-identity'
                }
            }
        }

        stage('Terraform Init') {
            agent {
                any {
                    image 'hashicorp/terraform:1.7.5'
                    args '-u root:root'
                }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh "terraform -chdir=envs/dev init"
                }
            }
        }

        stage('Terraform Plan') {
            agent {
                any {
                    image 'hashicorp/terraform:1.7.5'
                    args '-u root:root'
                }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh "terraform -chdir=envs/dev plan -var service=${SERVICE}"
                }
            }
        }

        stage('Terraform Apply') {
            agent {
                any {
                    image 'hashicorp/terraform:1.7.5'
                    args '-u root:root'
                }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh "terraform -chdir=envs/dev apply -auto-approve -var service=${SERVICE}"
                }
            }
        }
    }
}
