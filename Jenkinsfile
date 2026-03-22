pipeline {
    agent any

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

        stage('Show Selection') {
            steps {
                echo "Selected service: ${SERVICE}"
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh "terraform -chdir=envs/dev init"
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh "terraform -chdir=envs/dev plan -var service=${SERVICE}"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds']]) {
                    sh "terraform -chdir=envs/dev apply -auto-approve -var service=${SERVICE}"
                }
            }
        }
    }
}
