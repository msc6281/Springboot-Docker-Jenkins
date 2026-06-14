# Start jenkins in docker
docker run -d --name jenkins -u root -p 8080:8080 -p 5000:5000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins/jenkins:lts
# Jenkins secret password
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

# install docker in jenkins pipeline
apt-get update && apt-get install -y docker.io

# ✅ With optimization
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# in docker buildAvoids stale cached layers
--no-cache 
# Installs only required packages
--no-install-recommends 
# Removes package cacherm
apt-get clean 
# Removes apt lists
-rf /var/lib/apt/lists/* 

# Start Jenkins
docker start jenkins

# Run your app (currently running from jenkins pipeline)
docker run -d -p 9090:8080 --name springapp demoproject-ci-cd:latest

# Stop everything
docker stop jenkins springapp

# Check running containers
docker ps
