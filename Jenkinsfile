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
        bat "docker build -t qb-craft-demo ."
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
        bat "docker tag qb-craft-demo pkm23/quickbase:qb-craft-demo"
        bat "docker push pkm23/quickbase:qb-craft-demo"
      }
    }

    stage('Deploy to Minikube') {
      steps {
       withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]){
        withEnv(['KUBECONFIG=C:\\Users\\Pawan Mishra\\.kube\\config']) {
        bat """
          
	        kubectl delete deployment qb-craft-app --ignore-not-found
          kubectl delete service qb-craft-app-service --ignore-not-found
          kubectl config use-context minikube
          kubectl config current-context
          kubectl get pods
          kubectl auth can-i create deployment
          kubectl create deployment qb-craft-app --image=pkm23/quickbase:qb-craft-demo
          kubectl expose deployment qb-craft-app --type=NodePort --port=8080 --name=qb-craft-app-service
                   
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
