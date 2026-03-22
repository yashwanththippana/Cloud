pipeline {

    agent any   // All stages run on Jenkins controller where AWS CLI & Terraform are installed

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
            steps {
                checkout scm
            }
        }

        stage('Show Selection') {
            steps {
                echo "Selected service: ${SERVICE}"
            }
        }

        stage('Verify AWS Auth') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh '''
                        echo "Verifying AWS authentication..."
                        aws sts get-caller-identity
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh '''
                        echo "Running Terraform Init..."
                        terraform -chdir=envs/dev init
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh """
                        echo "Running Terraform Plan for service: ${SERVICE}"
                        terraform -chdir=envs/dev plan -var service=${SERVICE}
                    """
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh """
                        echo "Running Terraform Apply for service: ${SERVICE}"
                        terraform -chdir=envs/dev apply -auto-approve -var service=${SERVICE}
                    """
                }
            }
        }
    }
}
