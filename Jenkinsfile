pipeline {
    agent any
    environment {
        VERSION = 'latest'
        PROJECT = 'nginx-container'
		IMAGE = "$PROJECT"
		ECRURL = 'https://565323501885.dkr.ecr.eu-west-1.amazonaws.com/'
		ECRCRED = 'ecr:eu-west-1:aws-credential'
    }
    
    stages {
        stage('cloning Git') {
            steps {
                    checkout scm
                }
		    }        
        stage ('Lint source code') {
            steps {
                    echo 'Linting Dockerfile'
                    sh 'hadolint --ignore DL3006 /Dockerfile'
                }
            }

		stage('Build Docker image') {
            steps {
                script {
                    // Build the docker image using a Dockerfile
                        docker.build("$IMAGE")
                    }
                }
            }  

		stage('Push image to ECR') {
            steps {
                script {
                    // Push the Docker image to ECR
                        docker.withRegistry(ECRURL, ECRCRED) {
                        docker.image(IMAGE).push(VERSION)
                    }
                }
            }
            
        stage('Run nginx Container on DevServer') {
            steps {
                    withAWS(credentials: 'aws-credential', region: 'eu-west-1') {
                        sh "aws cloudformation create-stack --stack-name devserver --region eu-west-1 --template-body://provision.yml"
                        sh 'docker run -p 80:80 -d  --name Grid-app ${IMAGE}:${VERSION}'
                    }
                }
            }
    }
	post {
		always {
		    // make sure that the Docker image is removed
		    sh "docker rmi $IMAGE | true"
		    }
	    }
}