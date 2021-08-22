#!/bin/bash

# AWS Bootstrap
# By Michael Soh
#
# This bootstrap installs MySQL and Docker.  Docker is used to 
# install an apache web server with PHP, which then serve 
# all of my PHP projects, such as my mail aliases program, 
# squarecube, and myphpadmin.


#### VARIABLE DECLARATION ####


# Branch name is declared in the userdata.sh file, where this bootstrap
# is initially loaded.
echo BRANCH_NAME: ${BRANCH_NAME}

# Update apt-get
echo Updating apt-get repositories
DEBIAN_FRONTEND=noninteractive apt-get update -yqq

# Install all patches as necessary, assuming 'y' to questions, and
# supressing output
echo Upgrade all available packages
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yqq


# Populate SSH Server Keys
echo Getting SSH Host keys for bitbucket and github
ssh-keyscan github.com bitbucket.org >> ~/.ssh/known_hosts


# Install SSH deployment keys
# echo Downloading git deployment keys from S3
# aws s3 cp s3://mikesoh.com-galactica-backup/ssh_keys/bitbucket-deployment-keys/ ~/.ssh/ --recursive --quiet

# echo `ls -1 ~/.ssh/id_rsa* | wc -l` files downloaded.
# echo Public key as follows:
# echo ""
# cat ~/.ssh/id_rsa.pub
# echo ""

# echo Making the private key readable by owner only.
# chmod 600 ~/.ssh/id_rsa


# Download git repository
echo Downloading your bootstrap tarball version ${BRANCH_NAME}.  
echo     It will be placed in /tmp
curl -LkSs https://api.github.com/repos/cloud-mikesoh-com/aws-bootstrap/tarball/${BRANCH_NAME} -o /tmp/repo.tar.gz

echo Untarring the tarball.
tar -xzf /tmp/repo.tar.gz -C /tmp

if [[ -z ${PROFILE+x} ]]; then
  echo "No profile declared.  No further processing being performed."
else if [[ -f /tmp/cloud-mikesoh-com-aws-bootstrap-*/profiles/${PROFILE}.bash} ]]; then
  echo "Running ${PROFILE}.bash"
  source /tmp/cloud-mikesoh-com-aws-bootstrap-*/profiles/${PROFILE}.bash
fi

echo cloud-init userdata processed.
echo Setting shutdown for 2 hours in case I forget...
shutdown -h +120

echo You may disable this by running the following command:
echo     sudo shutdown -c
