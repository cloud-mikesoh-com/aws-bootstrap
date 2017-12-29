#!/bin/bash

#### VARIABLE DECLARATION ####
UBUNTU_VERSION=xenial
PACKAGE_VERSION='17.12.0~ce-0'

# Download the docker installation file
echo Downloading docker version ${PACKAGE_VERSION}
curl -LkSs https://download.docker.com/linux/ubuntu/dists/${UBUNTU_VERSION}/pool/stable/amd64/docker-ce_${PACKAGE_VERSION}~amd64.deb \
    -o /tmp/docker.deb

echo Installing docker
dpkg -i /tmp/docker.deb

# Configure
echo Do configuration stuff here

