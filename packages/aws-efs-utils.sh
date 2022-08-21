#!/bin/bash -xe
# Instructions transcribed from 
# https://docs.aws.amazon.com/efs/latest/ug/installing-amazon-efs-utils.html


#### VARIABLE DECLARATION ####
PACKAGE_VERSION='1.0.0'

echo Updating apt
apt-get update

echo Installing prerequisits
apt-get install -y git binutils stunnel4

echo Cloning efs-utils repository
git clone https://github.com/aws/efs-utils /tmp/efs-utils

cd /tmp/efs-utils
./build-deb.sh

echo Installing efs-utils
apt-get install -y ./build/amazon-efs-utils*.deb
