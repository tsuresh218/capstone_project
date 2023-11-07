if [ "$GIT_BRANCH" == "dev" ]; then
    echo "Building Dockers Image for Dev Branch..."

    DOCKER_IMAGE_NAME=my-react-app:latest
    DOCKER_USERNAME=$USERNAME
    DOCKER_PASSWORD=$PASSWORD
    DOCKER_REPO_NAME=dev

    docker build -t $DOCKER_IMAGE_NAME .
    echo "Docker Image Built: $DOCKER_IMAGE_NAME"

    echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

    docker tag $DOCKER_IMAGE_NAME $DOCKER_USERNAME/$DOCKER_REPO_NAME:${DOCKER_IMAGE_NAME##*:}
    docker push $DOCKER_USERNAME/$DOCKER_REPO_NAME:${DOCKER_IMAGE_NAME##*:}

    echo "Docker Image pushed to DockerHub"
fi

if [ "$GIT_BRANCH" == "master" ]; then
    echo "Building Docker Image for Master Branch..."

    DOCKER_IMAGE_NAME=my-react-app:latest
    DOCKER_USERNAME=$USERNAME
    DOCKER_PASSWORD=$PASSWORD
    DOCKER_REPO_NAME=prod

    docker build -t $DOCKER_IMAGE_NAME .
    echo "Docker Image Built: $DOCKER_IMAGE_NAME"

    echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

    docker tag $DOCKER_IMAGE_NAME $DOCKER_USERNAME/$DOCKER_REPO_NAME:${DOCKER_IMAGE_NAME##*:}
    docker push $DOCKER_USERNAME/$DOCKER_REPO_NAME:${DOCKER_IMAGE_NAME##*:}

    echo "Docker Image pushed to DockerHub"
fi
