#!/bin/bash

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
  echo "Docker is not running. Please start Docker and try again."
  exit 1
fi

# Default image name and tag
IMAGE_NAME="myimage"
TAG="latest"

# Allow tag as optional argument
if [ -n "$1" ]; then
  TAG="$1"
fi

# Build the Docker image
echo "Building Docker image: ${IMAGE_NAME}:${TAG}"
docker build -t "${IMAGE_NAME}:${TAG}" .

# Check if build was successful
if [ $? -eq 0 ]; then
  echo "Docker image ${IMAGE_NAME}:${TAG} built successfully."
else
  echo "Docker build failed."
  exit 1
fi
