#!/bin/bash

# Update apt-get
echo Updating apt-get repositories
apt-get update -yqq

# Install all patches as necessary, assuming 'y' to questions, and
# supressing output
echo Upgrade all available packages
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq

# Install pre-requisits
echo Installing AWS CLI and Python 3
apt-get install -yqq awscli python3

# Set timezone to US/Eastern
# https://help.ubuntu.com/community/UbuntuTime
echo "US/Eastern" | sudo tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

echo cloud-init userdata processed.
