#!/bin/bash -xe

#### VARIABLE DECLARATION ####
PACKAGE_VERSION='1.0.0'

echo Install prerequisite unzip
apt-get install -yqq zip unzip

if [[ -z "$AMI_ARCH" ]] then
  echo "Setting AMI_ARCH to amd64"
  AMI_ARCH="amd64"
else 
  echo "AMI_ARCH set to ${AMI_ARCH}"
fi

if [[ $AMI_ARCH -eq "amd64" ]] then  
  CURL_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
elif [[ $AMI_ARCH -eq "arm64" ]] then
  CURL_URL="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"
fi

# For the latest version of the AWS CLI, see:
# http://docs.aws.amazon.com/cli/latest/userguide/installing.html
echo Downloading awscliv2
curl ${CURL_URL} -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

aws --version
