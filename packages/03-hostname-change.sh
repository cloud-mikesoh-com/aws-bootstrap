#!/bin/bash

#### VARIABLE DECLARATION ####
PACKAGE_VERSION='1.0.0'

if [[ -z ${TARGET_HOSTNAME+x} ]]; then
  echo "TARGET_HOSTNAME is not set. Exiting."
else
  echo "Setting hostname to ${TARGET_HOSTNAME}."
  NEW_HOSTNAME=${TARGET_HOSTNAME}

  # Set hostname
  # Instructions on how to do this without restarting:
  # https://www.cyberciti.biz/faq/ubuntu-change-hostname-command/
  OLD_HOSTNAME=`cat /etc/hostname`
  echo Current Hostname: ${OLD_HOSTNAME}
  echo Setting hostname to ${NEW_HOSTNAME}
  hostname ${NEW_HOSTNAME}

  echo Modifying /etc/hostname
  sed -ri 's/'"${OLD_HOSTNAME}"'/'"${NEW_HOSTNAME}"'/g' /etc/hostname

  echo Modifying /etc/hosts
  sed -ri 's/^(127.0.0.1)\s+(\w+)$/\1 '"${NEW_HOSTNAME}"'/' /etc/hosts
fi
