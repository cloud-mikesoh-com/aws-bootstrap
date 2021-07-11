#!/bin/bash

# This file should be copied into the User Data section of creating AWS
# EC2 instances.
BRANCH_NAME="main"
BOOTSTRAP_FILE="https://raw.githubusercontent.com/sohmc/aws-bootstrap/${BRANCH_NAME}/bootstrap.sh"

# If you want to set the instance with a hostname, uncomment the following
# the following two lines
# TARGET_HOSTNAME="CHANGEME"
# export TARGET_HOSTNAME

echo Downloading Bootstrap from ${BOOTSTRAP_FILE}
export BRANCH_NAME
bash <(curl -s ${BOOTSTRAP_FILE})
