docker run -d --name jenkins -u root -p 8080:8080 -p 5000:5000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins/jenkins:lts

docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

#install docker in jenkins pipeline
apt-get update && apt-get install -y docker.io

# Start Jenkins
docker start jenkins

# Run your app (currently running from jenkins pipeline)
docker run -d -p 9090:8080 --name springapp demoproject-ci-cd:latest

# Stop everything
docker stop jenkins springapp

# Check running containers
docker ps
