#!/bin/bash -xe

# AWS Bootstrap
# By Michael Soh


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
echo Getting SSH Host keys for github
ssh-keyscan github.com >> ~/.ssh/known_hosts


# Download git repository
echo Downloading your bootstrap tarball version ${BRANCH_NAME}.  
echo     It will be placed in /tmp/repo
curl -LkSs https://api.github.com/repos/cloud-mikesoh-com/aws-bootstrap/tarball/${BRANCH_NAME} -o /tmp/repo.tar.gz

mkdir /tmp/repo

echo Untarring the tarball.
tar -xzf /tmp/repo.tar.gz -C /tmp/repo
export REPO_DIR=`ls /tmp/repo`

if [[ -z ${PROFILE+x} ]]; then
  echo "No profile declared.  No further processing being performed."
elif [[ -f "/tmp/repo/${REPO_DIR}/profiles/${PROFILE}.bash" ]]; then
  echo "Running ${PROFILE}.bash"
  source /tmp/repo/${REPO_DIR}/profiles/${PROFILE}.bash
else 
  ls -l /tmp/repo/${REPO_DIR}/profiles/${PROFILE}.bash
  echo "Profile ${PROFILE} not found.  No further processing being performed."
fi

echo cloud-init userdata processed.
echo Setting shutdown for 2 hours in case I forget...
shutdown -h +120

echo You may disable this by running the following command:
echo     sudo shutdown -c
