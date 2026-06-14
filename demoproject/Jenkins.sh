pipeline {
  agent any
  tools {
    maven 'Maven'
  }
  stages {
    stage('Checkout') {
      steps {
        git branch: 'main',
            url: 'https://github.com/msc6281/Springboot-Docker-Jenkins'
      }
    }
    stage('Build') {
      steps {
        dir('demoproject') {
          sh 'mvn clean package -DskipTests'
        }
      }
    }
    stage('Test') {
      steps {
        dir('demoproject') {
          sh 'mvn test'
        }
      }
    }
    stage('Docker Build') {
      steps {
        dir('demoproject') {
          sh 'docker build -t demoproject-ci-cd:latest .'
        }
      }
    }
    stage('Docker Run') {         
      steps {
        sh 'docker stop springapp || true'
        sh 'docker rm springapp || true'
        sh 'docker run -d -p 9090:8080 --name springapp demoproject-ci-cd:latest'
      }
    }
  }

  post {
    success {
      echo 'Pipeline successfully completed ✅'
    }
    failure {
      echo 'Pipeline failed'
    }
  }
}
