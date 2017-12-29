#!/bin/bash

#### VARIABLE DECLARATION ####
PACKAGE_VERSION='1:2.2.22-1ubuntu2.4'

# Install Package
echo Installing dovecot version ${PACKAGE_VERSION}

DEBIAN_FRONTEND=noninteractive apt-get install -yqq dovecot=${PACKAGE_VERSION} \
    dovecot-mysql=${PACKAGE_VERSION}

# Configure
echo Do configuration stuff here


