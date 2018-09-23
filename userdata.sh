#!/bin/bash

# This file should be copied into the User Data section of creating AWS
# EC2 instances.
BRANCH_NAME="update_docker_install"
BOOTSTRAP_FILE="https://raw.githubusercontent.com/sohmc/aws-bootstrap/${BRANCH_NAME}/bootstrap.sh"

echo Downloading Bootstrap from ${BOOTSTRAP_FILE}
bash <(curl -s ${BOOTSTRAP_FILE})


