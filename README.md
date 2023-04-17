# aws-docker-jenkins-miniproject

A simple project to integrate aws, docker and jenkins

## AWS

Lauch an EC2 instance with the below configuration

:gear: Configure Amazon Machine Image as Ubuntu Server
:gear: Create Key pair (type RSA and format .pem)
:gear: Configure Network settings to Allow SSH traffic from anywhere and Allow HTTPS/HTTP traffic from the internet
:gear: Lauch the EC2 instance
:gear: Go to the EC2 instance configuration, in Security area click on "Security group" and click then "Edit inbound rules". In next screen, add a rule where:

- Type: "Custom TCP"
  Port range: "8080"
  Source : "My IP"

Connect to your EC2 instance.

## Jenkins

### Create the Jenkins enviromment inside EC2 instance

1. Install Java

```shell script
sudo apt update
sudo apt install -y openjdk-11-jre
```

2. Install Jenkins

```shell script
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null 
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update 
sudo apt-get install -y jenkins
```

3. Start Jenkins

```shell script
sudo systemctl enable jenkins
sudo systemctl start jenkins
```

### Configure a basic Jenkins server

1. Go to "http://<PublicIP>:8080", to unlock Jenkins copy the output from ```sudo cat /var/lib/jenkins/secrets/initialAdminPassword``` and paste in Jenkins IU.
2. Install suggested plugins
3.
