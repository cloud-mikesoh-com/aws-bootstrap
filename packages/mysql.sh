#!/bin/bash

#### VERSION DECLARATION ####
MYSQL_VERSION='5.7.20-0ubuntu0.16.04.1'

# Install MySQL
echo Installing MySQL Server version ${MYSQL_VERSION}
echo     The password will be set to PASSWORD.  You can change this by
echo     issuing the following command:
echo         mysqladmin -u root password newpasswordgoeshere
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password PASSWORD'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password PASSWORD'

DEBIAN_FRONTEND=noninteractive apt-get install -yq mysql-server=${MYSQL_VERSION}
