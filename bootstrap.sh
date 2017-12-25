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
echo     The password will be set to PASSWORD.  You can change this by
echo     issuing the following command:
echo         mysqladmin -u root password newpasswordgoeshere
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password PASSWORD'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password PASSWORD'

DEBIAN_FRONTEND=noninteractive apt install -y mysql-server=${MYSQL_VERSION}
