#!/bin/bash

echo ----- DOCKER REPOSITORY -----

echo Downloading Docker\'s official GPG key...
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    apt-key add -

echo Inspecting fingerprint...
apt-key fingerprint 0EBFCD88

echo Adding repository docker repository to apt...
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

