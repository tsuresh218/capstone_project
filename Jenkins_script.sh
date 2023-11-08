#!/bin/bash

# Docker credentials
DOCKERHUB_USERNAME=$USERNAME
DOCKER_PASSWORD=$PASSWORD

# Jenkins sets the job's Git branch to the variable $GIT_BRANCH
branch=`echo "$GIT_BRANCH" | cut -d'/' -f 2`

# Docker image names
DEV_IMAGE=$USERNAME/dev
PROD_IMAGE=$USERNAME/prod

# Docker login
echo $DOCKER_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin

if [ "$branch" == "dev" ]; then
	echo "Building and pushing Docker image for Dev branch..."
    docker build -t $DEV_IMAGE:latest .
    echo "Publishing Dev image..."
    docker push $DEV_IMAGE:latest
fi

if [ "$branch" == "master" ]; then
	echo "Building and pushing Docker image for Prod branch..."
    docker build -t $PROD_IMAGE:latest .
    docker push $PROD_IMAGE:latest
fi
