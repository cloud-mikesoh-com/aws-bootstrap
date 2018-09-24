#!/bin/bash

# These script takes the commands relayed via 
# https://docs.docker.com/install/linux/docker-ce/ubuntu/

echo Downloading Docker\'s official GPG key...
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    apt-key add -

echo Inspecting fingerprint...
apt-key fingerprint 0EBFCD88

echo Adding repository...
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo Updating repositories
apt-get update

echo Installing docker
apt-get install docker-ce
