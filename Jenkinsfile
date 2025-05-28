pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/your-app-name'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'   // Jenkins credentials ID for Docker Hub
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Build with Gradle') {
            steps {
                sh './gradlew build'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    sh '''
                    # Set Docker CLI to use Minikube's Docker daemon if necessary
                    # eval $(minikube -p minikube docker-env)

                    # Create Kubernetes deployment YAML
                    cat <<EOF > k8s-deployment.yaml
                    apiVersion: apps/v1
                    kind: Deployment
                    metadata:
                      name: your-app
                    spec:
                      replicas: 1
                      selector:
                        matchLabels:
                          app: your-app
                      template:
                        metadata:
                          labels:
                            app: your-app
                        spec:
                          containers:
                          - name: your-app
                            image: your-dockerhub-username/your-app-name:latest
                            ports:
                            - containerPort: 8080
                    ---
                    apiVersion: v1
                    kind: Service
                    metadata:
                      name: your-app-service
                    spec:
                      selector:
                        app: your-app
                      ports:
                        - protocol: TCP
                          port: 80
                          targetPort: 8080
                      type: NodePort
                    EOF

                    # Apply deployment
                    kubectl apply -f k8s-deployment.yaml
                    '''
                }
            }
        }
    }
}
