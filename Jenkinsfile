pipeline {
  agent any
  environment {
    DOCKER_CREDENTIALS = credentials('dockerhub-creds')
  }
  stages {
    stage('Docker Login') {
      steps {
        bat """
          docker login -u %DOCKER_CREDENTIALS_USR% -p %DOCKER_CREDENTIALS_PSW%
        """
      }
    }
  }
}
