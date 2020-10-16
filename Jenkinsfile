pipeline {
  agent any
  environment
  {

      VERSION = 'latest'
      PROJECT = 'nginx-container'
      IMAGE = "$PROJECT"
      ECRURL = "https://565323501885.dkr.ecr.eu-west-1.amazonaws.com/$PROJECT"
      ECRCRED = 'ecr:eu-west-1:aws-credential'
  }
  stages {
    stage('Git checkout') {
        steps {
                checkout scm
            }
        }

    stage('Lint Dockerfile') {
        steps {
            sh 'docker run --rm -i hadolint/hadolint:v1.17.5 < Dockerfile'
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
    
    stage('Create a EC2 instance') {
        steps {
            withAWS(region:'eu-west-1',credentials:'aws-credentials') {
                sh "aws cloudformation create-stack --stack-name devserver --region eu-west-1 --template-body://provision.yml" 
                }
            }
        }

    stage('Run nginx Container on DevServer') {
        steps {
            withAWS(region:'eu-west-1',credentials:'aws-credentials') {
                sh "docker run -p 80:80 -d  --name Grid-app ${IMAGE}:${VERSION}"
                }
            }
        }
    }
}