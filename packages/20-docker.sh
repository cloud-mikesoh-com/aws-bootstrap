#!/bin/bash

#### VARIABLE DECLARATION ####
UBUNTU_VERSION=xenial
PACKAGE_VERSION='17.12.0~ce-0~ubuntu'

# Download the docker installation file
DOCKER_DL_URL="https://download.docker.com/linux/ubuntu/dists/${UBUNTU_VERSION}/pool/stable/amd64/docker-ce_${PACKAGE_VERSION}_amd64.deb"
echo Downloading docker version ${PACKAGE_VERSION} from
echo "    ${DOCKER_DL_URL}"
curl -LkSs ${DOCKER_DL_URL} -o /tmp/docker.deb

echo Installing dependencies
DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    libltdl7

echo Installing docker
dpkg -i /tmp/docker.deb

