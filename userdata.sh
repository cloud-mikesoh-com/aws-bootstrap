#!/bin/bash

# This file should be copied into the User Data section of creating AWS
# EC2 instaces.
echo Downloading Bootstrap from git@github.com:sohmc/aws-bootstrap/bootstrap.sh
bash <(curl -s https://raw.githubusercontent.com/sohmc/aws-bootstrap/master/bootstrap.sh)
