#!/bin/bash

# Update apt-get
echo Updating apt-get repositories
apt-get update -yqq

# Install all patches as necessary, assuming 'y' to questions, and
# supressing output
echo Upgrade all available packages
apt-get upgrade -yq

# Install pre-requisits
echo Installing AWS CLI and Python 3
apt-get install -yqq awscli python3

echo cloud-init userdata processed.
echo Setting shutdown for 2 hours in case I forget...
shutdown -h +120

