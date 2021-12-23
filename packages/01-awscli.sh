#!/bin/bash -xe

#### VARIABLE DECLARATION ####
PACKAGE_VERSION='1.0.0'

echo Install pre-requisits unzip
apt-get install -yqq zip unzip

# Install pre-requisits
# For the latest version of the AWS CLI, see:
# http://docs.aws.amazon.com/cli/latest/userguide/installing.html
echo Downloading awscliv2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

aws --version
