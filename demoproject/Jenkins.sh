pipeline{

  agent any

  tools{
    maven 'Maven'
  }

  stages{
     stage('Checkout'){
        steps{
          git 'https://github.com/msc6281/Springboot-Docker-Jenkins'
        }
     }
     stage('Build'){
        steps{
          sh 'mvn clean package -DskipTests'
        }
     }
     stage('Test'){
       steps{
          sh 'mvn test'
       }
     }
     stage('Docker Build'){
        steps{
           sh 'docker build -t demoProject-ci-cd:latest .'
        }
     }
  }

}