#!/bin/bash

# Path to the directory containing docker-compose.yml
DOCKERCOMPOSE_PATH='/home/ubuntu/reactjs-demo'
CONTAINER_NAME='capstone'

# Navigate to the path
cd $DOCKERCOMPOSE_PATH

#Run the Docker image
docker-compose up -d

# Check if Docker image is running
if [ $(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME) = "true" ]; then
    echo "Docker container '$CONTAINER_NAME is deployed and running"
else
    echo "Docker container '$CONTAINER_NAME is not deployed and running"
fi

# Check the docker container is running
docker ps -a
