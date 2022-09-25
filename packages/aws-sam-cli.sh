#!/bin/bash -xe

#### VARIABLE DECLARATION ####
PACKAGE_VERSION='1.0.0'

echo Install prerequisite unzip
apt-get install -yqq zip unzip

AMI_ARCH=`dpkg --print-architecture`
echo "AMI_ARCH set to ${AMI_ARCH}"


# For the latest version of the AWS SAM CLI, see:
# https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-linux.html

if [[ $AMI_ARCH == "amd64" ]]; then  
  CURL_URL="https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"
  echo Downloading aws sam cli...
  curl -L ${CURL_URL} -o "aws-sam-cli.zip"
  unzip aws-sam-cli.zip -d sam-installation
  ./sam-installation/install
elif [[ $AMI_ARCH == "arm64" ]]; then
  pip install aws-sam-cli
fi

sam --version
