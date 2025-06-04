pipeline {
    agent any

    environment {
      //  GITHUB_CRED = credential('GIT_HUB_CREDENTIALS')
      //  DOCKER_HUB_CRED = credential('DOCKER_HUB_PASSWORD')
        IMAGE_NAME = 'pkm23/quickbase:craft_demo'
        IMAGE_TAG = 'latest'
        GITHUB_URL = 'https://github.com/GitHubTestLogin/quickbase-demo.git'
    }

	stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh """
                    # Optionally update image in deployment file if not parameterized
                    sed -i 's|image: .*|image: ${IMAGE_NAME}|' quickbase-demo.yaml

                    # Apply deployment
                    kubectl apply -f quickbase-demo.yaml

                    # Wait for the deployment to complete
                    kubectl rollout status deployment.apps/demo-app
                """
            }
        }
    }

//    post {
 //       always {
 //           sh 'docker logout'
 //       }
//    }
}
