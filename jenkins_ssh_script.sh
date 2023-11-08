#bin/bash

DOCKER_IMAGE=tsuresh218/prod:latest
CONTAINER_NAME=my-application
DOCKERHUB_USERNAME=$USERNAME
DOCKER_PASSWORD=$PASSWORD

# Update repositories
sudo apt-get update

# Install docker
sudo apt-get install -y docker.io

# Verify Docker is installed
if [ "$(which docker)" != "" ]; then
    echo "Docker is installed at $(which docker)"
else
    echo "Docker is not installed, please check the installation step"
    exit 1
fi

#Give permission
sudo usermod -aG docker ubuntu

# Login to Docker
echo $DOCKER_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin

# Pull the Docker image
docker pull $DOCKER_IMAGE

if [ "$(sudo docker images -q $DOCKER_IMAGE 2> /dev/null)" != "" ]; then
    echo "Successfully pulled $DOCKER_IMAGE image"
else
    echo "Image could not be pulled, please verify the image name"
    exit 1
fi

# Run the image
sudo docker run -d -p 80:3000 --name $CONTAINER_NAME $DOCKER_IMAGE

#Verify the image is running
# Check if Docker image is running
if [ $(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME) = "true" ]; then
    echo "Docker container '$CONTAINER_NAME is deployed and running"
else
    echo "Docker container '$CONTAINER_NAME is not deployed and running"
fi

# Check the docker container is running
docker ps -a

## Exit Successfully
exit 0
