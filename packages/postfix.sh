#!/bin/bash

#### VERSION DECLARATION ####
POSTFIX_VERSION='3.1.0-3'


# Install Postfix
echo Installing Postfix version ${POSTFIX_VERSION}

DEBIAN_FRONTEND=noninteractive apt-get install -yq postfix=${POSTFIX_VERSION} postfix-mysql=${POSTFIX_VERSION}


# Install support packages
apt-get install -yq procmail
