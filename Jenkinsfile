pipeline {
    agent any

    environment {
      //  GITHUB_CRED = credential('GIT_HUB_CREDENTIALS')
      //  DOCKER_HUB_CRED = credential('DOCKER_HUB_PASSWORD')
        IMAGE_NAME = 'pkm23/quickbase:quickbase-demo'
        IMAGE_TAG = 'latest'
        GITHUB_URL = 'https://github.com/GitHubTestLogin/quickbase-demo.git'
    }

    stages {
        stage('Checkout Code') {
            steps {
          //      git branch: 'master', url: "${GITHUB_URL}"
		git 'https://github.com/GitHubTestLogin/quickbase-demo.git'
            }
        }

        stage('Build with Gradle') {
            steps {
                sh './gradlew clean build'
            }
        }

//        stage('Login to Docker Hub') {
 //           steps {
  //              sh """
  //                  echo "${DOCKER_HUB_PASS}" | docker login -u "${DOCKER_HUB_USR}" --password-stdin //
 //               """
 //           }
//        }
	stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Build Docker Image') {

            steps {
                sh """
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                """
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "docker tag quickbase-demo ${IMAGE_NAME}:${IMAGE_TAG}"
                sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh """
                    # Optionally update image in deployment file if not parameterized
                    sed -i 's|image: .*|image: ${IMAGE_NAME}:${IMAGE_TAG}|' quickbase-demo.yaml

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
