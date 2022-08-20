#!/bin/bash -xe

#### VARIABLE DECLARATION ####
PACKAGE_VERSION='1.0.0'

echo Install prerequisite unzip
apt-get install -yqq zip unzip

AMI_ARCH=`dpkg --print-architecture`
echo "AMI_ARCH set to ${AMI_ARCH}"


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
