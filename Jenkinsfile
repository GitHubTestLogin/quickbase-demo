pipeline {
  agent any

  environment {
    // DockerHub credentials (username/password)
    DOCKER_CREDENTIALS = credentials('dockerhub-creds')
    IMAGE_NAME = 'https://github.com/GitHubTestLogin/quickbase-demo.git'
    IMAGE_TAG = 'latest'
  }

  stages {

      
    stage('Docker Login') {
      steps {
        bat """
          //docker logout
          docker login -u %DOCKER_CREDENTIALS_USR% -p %DOCKER_CREDENTIALS_PSW%
        """
      }
    }

    stage('Deploy to Minikube') {
      steps {
       withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]){
       // withEnv(['KUBECONFIG=C:\\Users\\Pawan Mishra\\.kube\\config']) {
        bat """
          
          kubectl delete deployment qb-craft-app --ignore-not-found
          kubectl delete service qb-craft-app-service --ignore-not-found
          kubectl config use-context minikube
          kubectl config current-context
          kubectl get pods
          kubectl auth can-i create deployment
          kubectl create deployment qb-craft-app --image=pkm23/quickbase:qb-craft_demo
          kubectl expose deployment qb-craft-app --type=NodePort --port=8080 --name=qb-craft-app-service

          //kubectl apply -f quickbase-demo.yaml
        """
      //}
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
