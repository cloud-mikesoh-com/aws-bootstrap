#!/bin/bash

#### VARIABLE DECLARATION ####
PACKAGE_VERSION='1.0.0'

# Install Package
echo Downloading publish SSH keys for sohmc

# Install authorized keys
echo Downloading authorized_keys from github
curl -L "https://github.com/sohmc/ssh-keys/releases/download/latest/authorized_keys" \
    -o "/tmp/authorized_keys" && \
    rm ~ubuntu/.ssh/authorized_keys && \
    mv /tmp/authorized_keys ~ubuntu/.ssh/authorized_keys && \
    chown ubuntu:ubuntu ~ubuntu/.ssh/authorized_keys && \
    chmod 600 ~ubuntu/.ssh/authorized_keys

echo Authorized keys updated.  Showing public keys installed:
cat ~ubuntu/.ssh/authorized_keys
