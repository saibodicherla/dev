pipeline {
  agent any
  environment
  {

      VERSION = 'latest'
      PROJECT = 'nginx-container'
      IMAGE = "$PROJECT"
      ECRURL = "https://565323501885.dkr.ecr.eu-west-1.amazonaws.com/$PROJECT"
      ECRCRED = 'ecr:eu-west-1:aws-credentials'
  }
  stages {
    stage('Git checkout') {
        steps {
                checkout scm
            }
        }

    stage('Build Docker Image') {
        steps {
            script{
                // Build the docker image using a Dockerfile
                    docker.build('$IMAGE')
                }
            }
        }   
    stage('Push Image to ECR') {
        steps {
            script {    
                // Push the Docker image to ECR    
                    docker.withRegistry(ECRURL, ECRCRED) 
                    {
                        docker.image(IMAGE).push()
                    }                  
                }  
            }        
        }
    
    stage('Deploy nginx Container on EC2') {
        steps {
            withAWS(region:'eu-west-1',credentials:'aws-credentials') {
                sh "aws cloudformation create-stack --stack-name ngnix --region eu-west-1 --template-body file://provision.yml"  
                }
            }
        }
    }
}