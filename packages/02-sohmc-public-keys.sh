#!/bin/bash

#### VARIABLE DECLARATION ####
PACKAGE_VERSION='1.0.0'

# Install Package
echo Downloading publish SSH keys for sohmc

# Install authorized keys
echo Downloading authorized_keys from github
curl -L "https://github.com/sohmc/ssh-keys/releases/download/latest/authorized_keys" \
    -o "/tmp/authorized_keys"

if [[ -d ~ubuntu/.ssh ]]; then
  if [[ -f ~ubuntu/.authorized_keys ]]; then
    echo Removing existing authorized keys
    rm ~ubuntu/.ssh/authorized_keys
  fi
else
  echo Making .ssh directory
  mkdir ~ubuntu/.ssh
fi


echo Moving authorized_keys from tmp to .ssh
mv /tmp/authorized_keys ~ubuntu/.ssh/authorized_keys

echo chowning to ubuntu
chown ubuntu:ubuntu ~ubuntu/.ssh/authorized_keys && \

echo chmoding to strict user ownership
chmod 600 ~ubuntu/.ssh/authorized_keys

echo Authorized keys updated.  Showing public keys installed:
cat ~ubuntu/.ssh/authorized_keys
