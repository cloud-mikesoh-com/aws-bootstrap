#!/bin/bash

# AWS Bootstrap
# By Michael Soh
#
# This bootstrap installs MySQL and Docker.  Docker is used to 
# install an apache web server with PHP, which then serve 
# all of my PHP projects, such as my mail aliases program, 
# squarecube, and myphpadmin.


#### VARIABLE DECLARATION ####
NEW_HOSTNAME='husker.mikesoh.com'

# Download AWS Bootstrap Files
# Branch name is declared in the userdata.sh file, where this bootstrap
# is initially loaded.
echo BRANCH_NAME: ${BRANCH_NAME}

# Update apt-get
echo Updating apt-get repositories
apt-get update -yqq

# Install all patches as necessary, assuming 'y' to questions, and
# supressing output
echo Upgrade all available packages
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yqq

echo Install zip and unzip
apt-get install -yqq zip unzip

# Install pre-requisits
echo Installing AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

aws --version

# Install SSH deployment keys
echo Downloading git deployment keys from S3
aws s3 cp s3://mikesoh.com-galactica-backup/ssh_keys/bitbucket-deployment-keys/ ~/.ssh/ --recursive --quiet

echo `ls -1 ~/.ssh/id_rsa* | wc -l` files downloaded.
echo Public key as follows:
echo ""
cat ~/.ssh/id_rsa.pub
echo ""

echo Making the private key readable by owner only.
chmod 600 ~/.ssh/id_rsa

# Install authorized keys
echo Downloading authorized_keys from github
curl -L "https://github.com/sohmc/ssh-keys/releases/download/latest/authorized_keys" \
    -o "/tmp/authorized_keys" && \
    rm ~ubuntu/.ssh/authorized_keys && \
    mv /tmp/authorized_keys ~ubuntu/.ssh/authorized_keys && \
    chown ubuntu:ubuntu ~ubuntu/.ssh/authorized_keys && \
    chmod 600 ~ubuntu/.ssh/authorized_keys

# Set hostname
# Instructions on how to do this without restarting:
# https://www.cyberciti.biz/faq/ubuntu-change-hostname-command/
OLD_HOSTNAME=`cat /etc/hostname`
echo Current Hostname: ${OLD_HOSTNAME}
echo Setting hostname to ${NEW_HOSTNAME}
hostname ${NEW_HOSTNAME}

echo Modifying /etc/hostname
sed -ri 's/'"${OLD_HOSTNAME}"'/'"${NEW_HOSTNAME}"'/g' /etc/hostname

echo Modifying /etc/hosts
sed -ri 's/^(127.0.0.1)\s+(\w+)$/\1 '"${NEW_HOSTNAME}"'/' /etc/hosts


# Populate SSH Server Keys
echo Getting SSH Host keys for bitbucket and github
ssh-keyscan github.com bitbucket.org >> ~/.ssh/known_hosts

echo cloud-init userdata processed.
echo Setting shutdown for 2 hours in case I forget...
shutdown -h +120

echo You may disable this by running the following command:
echo     sudo shutdown -c
