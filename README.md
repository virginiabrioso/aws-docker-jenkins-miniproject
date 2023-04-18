# aws-docker-jenkins-miniproject

A simple project to integrate aws, docker and jenkins

## AWS

Create an EC2 instance with the below configuration

:gear: Amazon Machine Image as Ubuntu Server

:gear: Key pair type RSA and format .pem

:gear: Network settings set to Allow SSH traffic from anywhere and Allow HTTPS/HTTP traffic from the internet

Launch instance, then go to the EC2 instance configuration

:gear: In Security area click on "Security group" and click then "Edit inbound rules". Add the following Inbound Rule:

- Type: "Custom TCP"
- Port range: "8080"
- Source : "My IP"

Connect to your EC2 instance.

## Docker

Docker-related settings are inside the CICD Pipeline.

The image used for the node app is in [Dockerfile](./Dockerfile) and the commands to build/run are in [Jenkinsfile](./Jenkinsfile)

It is only necessary to install Docker

```shell script
sudo apt update
sudo apt install -y docker.io
sudo chmod 666 /var/run/docker.sock
```

## Jenkins

### Create the Jenkins enviromment inside EC2 instance

1. Install Java

```shell script
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

1. To unlock Jenkins, copy the output from ```sudo cat /var/lib/jenkins/secrets/initialAdminPassword``` and paste in "http://PublicIP:8080" admin password field.
2. Install suggested plugins
3. Follow Setup Wizard config

### Create our CI/CD Pipeline

1. Create a SSH key, run ```ssh-keygen```
2. Save your Public SSH Key, it is the output from ```sudo cat /home/ubuntu/.ssh/id_rsa.pub```
3. Go to <http://PublicIP:8080/manage/credentials/store/system/domain/_/newCredentials> and create a new credential. In this case we are using a cred with the below configuration:

- Kind: SSH Username with private key
- Username: ubuntu
- Private Key: Your Public SSH Key

4. In Jenkins Dashboard, click in "New Item" then enter the desired pipeline name and select type "pipeline", create Jenkins job for your pipeline
5. In the job Configuration area, configure it to use

- SCM: Git
- Repository URL: Your github repo. E.g: <https://github.com/virginiabrioso/aws-docker-jenkins-miniproject.git>
- Credential: Cred create in Step 3
- Branch Specifier: */main

6. Save changes

Now by clicking in "Build Now" in the new pipeline you should be able have your node app containerized by Docker and reachable :smile

7. Let's make this node app public reachable. To it create an Inbound rule where

- Type: "Custom TCP"
- Port range: "8000"
- Source : "Anywhere IPV4"

After that you should be to get node app by accessing <http://PublicIP:8000>

## Make now the CD part

So for now we have a CI env, since we have to manually trigger the pipeline job to build the Node app container. So Let's go to CD part

1. In Jenkins go to "manage/pluginManager/available" and install "Github Integration" plugin. Restart Jenkins.
2. Go to your job configuration and enable "GitHub hook trigger for GITScm polling"
3. In your Github Repo create a WebHook, first go to "settings/hooks" and click "Add webhook", then confirm you github password and create the webhook with Payload URL "http://PublicIP:8080/github-webhook"
4. In settings/ssh/new in Github create a new SSH Key with the output from ```sudo cat /home/ubuntu/.ssh/id_rsa.pub```

## Yey, your CICD pipeline is done

Now everytime you change your repository Jenkins will create a build in your job pipeline with these new changes

## Reference

[Live DevOps Project for Resume - Jenkins CICD with GitHub Integration by TrainWithShubham](https://www.youtube.com/watch?v=nplH3BzKHPk&list=PLlfy9GnSVerRqYJgVYO0UiExj5byjrW8u&index=15)
