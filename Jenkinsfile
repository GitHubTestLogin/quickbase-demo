pipeline {
  agent any

  environment {
    // DockerHub credentials (username/password)
    DOCKER_CREDENTIALS = credentials('dockerhub-creds')
    IMAGE_NAME = 'https://github.com/GitHubTestLogin/quickbase-demo.git'
    IMAGE_TAG = 'latest'
  }

  stages {

    stage('Checkout Code from GitHub') {
      steps {
        git url: 'https://github.com/GitHubTestLogin/quickbase-demo.git', branch: 'master'
      }
    }

    stage('Build with Gradle') {
      steps {
        bat './gradlew clean build'
      }
    }

   stage('Build Docker Image') {
      steps {
        bat "docker build -t craft-img ."
      }
    }
    
    stage('Docker Login') {
      steps {
        bat """
          docker login -u %DOCKER_CREDENTIALS_USR% -p %DOCKER_CREDENTIALS_PSW%
        """
      }
    }

    stage('Push Docker Image to Docker Hub') {
      steps {
        bat "docker tag craft-img pkm23/quickbase:craft-img"
        bat "docker push pkm23/quickbase:craft-img"
      }
    }

    stage('Deploy to Minikube') {
      steps {
       withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]){
        withEnv(['KUBECONFIG=C:\\Users\\Pawan Mishra\\.kube\\config']) {
        bat """
          
	        kubectl delete deployment craft-app --ignore-not-found
          kubectl delete service craft-app-service --ignore-not-found
          kubectl config use-context minikube
          kubectl config current-context
          kubectl get pods
          kubectl auth can-i create deployment
          kubectl create deployment craft-app --image=pkm23/quickbase:craft-img
          kubectl expose deployment craft-app --type=NodePort --port=8080 --name=craft-app-service
                   
        """
      }
    }
  }
}   
}
  post {
    failure {
      echo 'Pipeline failed.'
    }
    success {
      echo 'Pipeline completed successfully.'
    }
  }
}
