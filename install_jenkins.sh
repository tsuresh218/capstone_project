#!/bin/bash

# Define the variable to store the process name
jenkins_process="jenkins"

#Download jdk:
# Check for JDK version
java_version=$(java -version 2>&1 >/dev/null | grep 'openjdk version' | awk '{print $3}' | tr -d \" | cut -d'.' -f1-2)

if [[ $java_version == "11.0" ]]; then
    echo " JDK 11 is already installed"
else
    echo " JDK 11 is not installed. Installing now..."
fi

# update the package list
sudo apt update -y

# Install the JDK
sudo apt install openjdk-11-jdk -y

if java -version 2>&1 >/dev/null | grep -q "openjdk version \"11."; then
    echo "JDK 11 is installed successfully"
else
    echo " JDK 11 installation failed"
fi

# Download the repo and import the required key:

wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -

sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  

sudo apt-get update

sudo apt-get install jenkins -y

#Enable Jenkins:
sudo service jenkins enable

#Start Jenkins:
sudo service jenkins start

if sudo service jenkins status
   then
   echo "Jenkins is running"
else
   echo "Jenkins is not running, starting the service"
   sudo service jenkins start
fi
   if [ $? -eq 0 ]; then
        echo "Jenkins started successfully"
    else
        echo "Failed to start Jenkins"
    fi
