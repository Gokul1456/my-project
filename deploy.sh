#!/bin/bash

# Docker Hub credentials (use environment variables for security)
DOCKER_USERNAME="gokul1114"
DOCKER_PASSWORD="Gokul2003@"

# Set the repository names
PUBLIC_REPO="gokul1114/dev"
PRIVATE_REPO="gokul1114/prod"

# Define the Docker image tag
TAG="latest"

# Choose repository type: "dev" or "prod"
REPO_TYPE=$1

if [ "$REPO_TYPE" == "dev" ]; then
    REPO_NAME=$PUBLIC_REPO
elif [ "$REPO_TYPE" == "prod" ]; then
    REPO_NAME=$PRIVATE_REPO
else
    echo "Please specify 'dev' or 'prod' as the repository type."
    exit 1
fi

# Authenticate with Docker Hub
echo "Authenticating with Docker Hub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
if [ $? -ne 0 ]; then
    echo "Failed to authenticate with Docker Hub. Check your credentials."
    exit 1
fi

# Build the Docker image
echo "Building the Docker image..."
docker build -t $REPO_NAME:$TAG .
if [ $? -ne 0 ]; then
    echo "Failed to build the Docker image."
    exit 1
fi

# Push the Docker image to the specified repository
echo "Pushing the image to $REPO_NAME..."
docker push $REPO_NAME:$TAG
if [ $? -ne 0 ]; then
    echo "Failed to push the Docker image to $REPO_NAME."
    exit 1
fi

# Log out of Docker Hub
echo "Logging out of Docker Hub..."
docker logout
if [ $? -eq 0 ]; then
    echo "Successfully logged out of Docker Hub."
else
    echo "Failed to log out of Docker Hub."
fi

echo "Deployment to Docker Hub ($REPO_TYPE repository) is complete."

