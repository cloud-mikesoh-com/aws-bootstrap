#!/bin/bash

# This file should be copied into the User Data section of creating AWS
# EC2 instances.
BOOTSTRAP_FILE='https://raw.githubusercontent.com/sohmc/aws-bootstrap/changing-version-numbers/bootstrap.sh'

echo Downloading Bootstrap from ${BOOTSTRAP_FILE}
bash <(curl -s ${BOOTSTRAP_FILE})


