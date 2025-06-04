pipeline {
    agent any

    environment {
      //  GITHUB_CRED = credential('GIT_HUB_CREDENTIALS')
      //  DOCKER_HUB_CRED = credential('DOCKER_HUB_PASSWORD')
        IMAGE_NAME = 'pkm23/quickbase:craft_demo'
        IMAGE_TAG = 'latest'
        GITHUB_URL = 'https://github.com/GitHubTestLogin/quickbase-demo.git'
    }
  stages {
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
                    # Apply deployment
                    kubectl apply -f quickbase-demo.yaml
                """
            }
       }
    }
}
