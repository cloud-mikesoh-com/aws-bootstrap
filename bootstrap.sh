#!/bin/bash

# AWS Bootstrap
# By Michael Soh
#
# This bootstrap installs MySQL and Docker.  Docker is used to 
# install an apache web server with PHP, # which then serve 
# all of my PHP projects, such as my mail aliases program, 
# squarecube, and myphpadmin.


#### VARIABLE DECLARATION ####
BOOTSTRAP_VERSION='0.3.0'
NEW_HOSTNAME='husker.mikesoh.com'

# Update apt-get
echo Updating apt-get repositories
apt-get update -yqq

# Install all patches as necessary, assuming 'y' to questions, and
# supressing output
echo Upgrade all available packages
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq

# Install pre-requisits
echo Installing AWS CLI
apt-get install -yqq awscli


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


# Download AWS Bootstrap Files
echo Downloading your bootstrap tarball version ${BOOTSTRAP_VERSION}.  
echo     It will be placed in /tmp
curl -LkSs https://api.github.com/repos/sohmc/aws-bootstrap/tarball/${BOOTSTRAP_VERSION} -o /tmp/master.tar.gz

echo Untarring the tarball.
tar -xzf /tmp/master.tar.gz -C /tmp

echo Processing package bash files
for f in $( ls /tmp/sohmc-aws-bootstrap-*/packages/*.sh ); do
    echo Running Script $f
    bash $f
done

echo cloud-init userdata processed.
