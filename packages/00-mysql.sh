#!/bin/bash

#### VERSION DECLARATION ####
MYSQL_VERSION='5.7.*'

BACKUP_LOCATION='s3://mikesoh.com-galactica-backup/mysql-backups/latest/'

# Install MySQL
echo Installing MySQL Server version ${MYSQL_VERSION}
echo "    The password will be set to PASSWORD.  You can change this by"
echo "    issuing the following command:"
echo "        mysqladmin -u root password newpasswordgoeshere"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password PASSWORD'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password PASSWORD'

DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    mysql-server=${MYSQL_VERSION}

# Download the latest backup from S3 bucket
echo Downloading the latest backup from the S3 Bucket
echo     ${BACKUP_LOCATION}
aws s3 cp ${BACKUP_LOCATION} /tmp/ --recursive --quiet

# Untar the tar file
echo Untarring the file
tar xzf /tmp/mysqldump*.tar.gz -C /tmp

# Import the mysqldump
echo Importing the mysqldump file into the database
mysql -u root --password=PASSWORD --force < /tmp/mysqldump.sql

echo Restarting MySQL Database
service mysql restart

echo Done.
