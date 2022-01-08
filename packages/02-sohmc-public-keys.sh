#!/bin/bash

#### VARIABLE DECLARATION ####
PACKAGE_VERSION='2.0.0'

# Install Package
echo Downloading publish SSH keys

# Install authorized keys
echo Downloading authorized_keys from github
curl -L "https://github.com/sohmc/ssh-keys/releases/download/latest/authorized_keys" \
    -o "/tmp/authorized_keys"

if [[ -z $1 ]]; then
  echo "No user specified; using current user: ${USER}"
  TARGET_USER=$USER
else
  echo "Installing authorized_keys for user: $1"
  TARGET_USER=$1
fi

TARGET_USER_DIR=$(eval echo ~${TARGET_USER});

if [[ ! -d `eval echo ${TARGET_USER_DIR}` ]]; then
  echo "${TARGET_USER_DIR} does not exist.  Exiting."
  exit 1
else
  if [[ -d ${TARGET_USER_DIR}/.ssh ]]; then
    if [[ -f ${TARGET_USER_DIR}/.ssh/authorized_keys ]]; then
      echo Removing existing authorized keys
      rm ${TARGET_USER_DIR}/.ssh/authorized_keys
    fi
  else
    echo Making .ssh directory
    mkdir ${TARGET_USER_DIR}/.ssh
  fi

  echo Moving authorized_keys from tmp to .ssh
  mv /tmp/authorized_keys ${TARGET_USER_DIR}/.ssh/authorized_keys

  echo chowning to ${TARGET_USER}
  chown ${TARGET_USER}:${TARGET_USER} ${TARGET_USER_DIR}/.ssh/authorized_keys

  echo chmoding to strict user ownership
  chmod 600 ${TARGET_USER_DIR}/.ssh/authorized_keys

  echo Authorized keys updated.  Showing public keys installed:
  cat ${TARGET_USER_DIR}/.ssh/authorized_keys
fi
