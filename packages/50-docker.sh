#!/bin/bash

echo "----- DOCKER REPOSITORY -----"

echo "Downloading Docker\'s official GPG key..."
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "Adding repository docker repository to apt..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Refreshing apt-get..."
DEBIAN_FRONTEND=noninteractive apt-get update -yqq

echo "Installing docker and docker-compose"
DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    docker-ce \
    docker-compose
