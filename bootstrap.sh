#!/bin/bash

# AWS Bootstrap
# By Michael Soh
#
# This bootstrap installs MySQL and Docker.  Docker is used to 
# install an apache web server with PHP, # which then serve 
# all of my PHP projects, such as my mail aliases program, 
# squarecube, and myphpadmin.


#### VERSION DECLARATION ####
bootstrap_version='0.1.0'

# Update apt-get
echo Updating apt-get repositories
apt-get update -yq

# Install all patches as necessary, assuming 'y' to questions, and
# supressing output
echo Upgrade all available packages
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq

# Install pre-requisits
echo Installing AWS CLI
apt-get install -yq awscli

# Download AWS Bootstrap Files
echo Downloading your bootstrap tarball.  It will be placed in /tmp
curl -LkSs https://api.github.com/repos/sohmc/aws-bootstrap/tarball/${bootstrap_version} -o /tmp/master.tar.gz

echo Untarring the tarball.
tar -xzf /tmp/master.tar.gz -C /tmp

echo Processing package bash files
for f in /tmp/sohmc-aws-bootstrap-*/packages/*.sh
do
    echo Running Script $f
    bash $f
done

echo cloud-init userdata processed.
