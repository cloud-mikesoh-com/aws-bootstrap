#!/bin/bash

#### VARIABLE DECLARATION ####

# Install Package
echo Installing dovecot

DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    dovecot-core \
    dovecot-pop3d \
    dovecot-imapd \
    dovecot-antispam \
    dovecot-mysql 


echo Stopping dovecot...
systemctl stop dovecot

echo Copying dovecot configuration files from /etc/dovecot to /etc/dovecot__DEFAULT
cp -rf /etc/dovecot /etc/dovecot__DEFAULT

# Configure authentication
echo "===== 10-auth.conf ====="
echo Disabling plaintext authentication
sed -ri 's/^#(disable_plaintext_auth = yes)$/\1/' /etc/dovecot/conf.d/10-auth.conf

echo Enabling login authentication
sed -ri 's/^(auth_mechanisms) =/\1 = plain login cram-md5/' /etc/dovecot/conf.d/10-auth.conf

echo Enabling authentication via passwd file
sed -ri 's/^#(!include auth-passwdfile.conf.ext)$/\1/' /etc/dovecot/conf.d/10-auth.conf

echo Starting dovecot...
systemctl start dovecot
