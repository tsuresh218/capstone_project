#!/bin/bash

# Define the variables
IMAGE_NAME='my-react-app'
TAG='latest'
CONTAINER_NAME='capstone'
DOCKERFILE_PATH='/mnt/c/Users/USER/Documents/capstone/reactjs-demo'

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
echo "Docker does not seems to be running, run it first and retry"
exit 1
fi

#Build Docker image
docker build -t $IMAGE_NAME:$TAG .

# Check if Docker image creation was successful
if [ $? -eq 0 ]; then
    echo "Docker image '$IMAGE_NAME:$TAG' has been built successfully."
else
    echo "Failed to build the Docker image '$IMAGE_NAME:$TAG'."
    exit 1
fi
