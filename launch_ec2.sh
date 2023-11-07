#!/bin/bash

# Replace with your Docker image name
DOCKER_IMAGE="imgae_on_docker_repo"

#Local public IP address
MY_IP=$(curl -s https://ipecho.net/plain)

# AWS Key Pair
KEY_PAIR="key_pair_name"

# Laucn AWS EC2 instance
INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0csgsjglw --count 1 --instance-type t2.micro --key-name $KEY_PAIR --query 'Instances[0].Instance.Id' --output text)

echo "Launched instance $INSTANCE_ID, waiting for it to start-up..."

# Wait for Instance to start
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

# Get Public IP of Instance
INSTANCE_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

echo "Instances running and can be accessed via IP: $INSTANCE_IP"

# Create security groups
SG_ID=$(aws ec2 create-security-group --group-name my-security-group --description "My security group" --output text)

# Limit SSH access to single IP address
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 22 --cidr $MY_IP/32

# Allow access to all IP addresses for the web application
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 80 --cidr 0.0.0.0/0

# Assign new security group to instance
aws ec2 modify-instance-attribute --instance-id $INSTANCE_ID --groups $SG_ID

# SSH into EC2 instance and install docker, then copy Docker image and run it
ssh -o StrictHostKeyChecking=no -i $KEY_PAIR.pem ubuntu@$INSTANCE_IP << EOF
    sudo apt update
    sudo apt install docker.io -y
    sudo service docker start
    sudo docker pull $DOCKER_IMAGE
    sudo docker run -d -p 80:80 $DOCKER_IMAGE
    sleep 5
    if [ $(sudo docker ps | grep $DOCKER_IMAGE | wc -l) -gt 0]
    then
        echo "Docker is running fine"
    else
        echo "Something went wrong"
    fi
EOF