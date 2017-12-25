#!/bin/bash

# AWS Bootstrap
# By Michael Soh
#
# This bootstrap installs MySQL and Docker.  Docker is used to 
# install an apache web server with PHP, # which then serve 
# all of my PHP projects, such as my mail aliases program, 
# squarecube, and myphpadmin.

#### VERSION DECLARATION ####
MYSQL_VERSION='5.7.20-0ubuntu0.16.04.1'



# Update apt
echo Updating apt repositories
apt update

# Install all patches as necessary, assuming 'y' to questions, and
# supressing output
echo Upgrade all available packages
DEBIAN_FRONTEND=noninteractive apt upgrade -yq

# Install MySQL
echo Installing MySQL Server version ${MYSQL_VERSION}
apt install -y mysql-server=${MYSQL_VERSION}
