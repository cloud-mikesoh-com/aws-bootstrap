#!/bin/bash

#### VARIABLE DECLARATION ####
POSTFIX_VERSION='3.1.0-3'
POSTFIX_REPO='git@bitbucket.org:sohmc/postfix-config.git'


# Install Postfix
echo Installing Postfix version ${POSTFIX_VERSION}

DEBIAN_FRONTEND=noninteractive apt-get install -yq postfix=${POSTFIX_VERSION} postfix-mysql=${POSTFIX_VERSION}

# Stop Postfix
echo Stopping Postfix service
service postfix stop

echo Moving postfix configuration files from /etc/postfix to /etc/postfix__DEFAULT
cp -r /etc/postfix /etc/postfix__DEFAULT

# Clone the postfix configuration repository
echo Cloning the postfix configuration repository
echo "   from ${POSTFIX_REPO}"
echo "   into /tmp/postfix-config-repo"
git clone -q ${POSTFIX_REPO} /tmp/postfix-config-repo


# Install support packages
apt-get install -yq procmail
