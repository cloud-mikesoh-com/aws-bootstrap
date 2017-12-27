#!/bin/bash

#### VARIABLE DECLARATION ####
POSTFIX_VERSION='3.1.0-3'
POSTFIX_REPO='git@bitbucket.org:sohmc/postfix-config.git'


# Install Postfix
echo Installing Postfix version ${POSTFIX_VERSION}

DEBIAN_FRONTEND=noninteractive apt-get install -yqq postfix=${POSTFIX_VERSION} postfix-mysql=${POSTFIX_VERSION} procmail

# Stop Postfix
echo Stopping Postfix service
service postfix stop

echo Copying postfix configuration files from /etc/postfix to /etc/postfix__DEFAULT
cp -r /etc/postfix /etc/postfix__DEFAULT

# Clone the postfix configuration repository
echo Cloning the postfix configuration repository
echo "   from ${POSTFIX_REPO}"
echo "   into /tmp/postfix-config-repo"
git clone -q ${POSTFIX_REPO} /tmp/postfix-config-repo

# Starting configuration of Postfix
echo Starting configuration of Postfix

echo "===== main.cf ====="
echo Setting relayhost to AWS SMTP Server
sed -ir 's/^(relayhost)\s*=/\1 = [email-smtp.us-east-1.amazonaws.com]:587/' /etc/postfix/main.cf

echo Inserting SMTP Options...
for t in /tmp/postfix-config-repo/postfix/main.cf-injections/*.cf
do
    echo Injecting file $t into main.cf
    echo "" >> /etc/postfix/main.cf
    cat $t >> /etc/postfix/main.cf
done

echo ""

echo Copying files for virtual aliases
cp -r /tmp/postfix-config-repo/postfix/virtual /etc/postfix/

echo "===== sasl_passwd ====="
echo Copying sasl_passwd from the repository...
cp /tmp/postfix-config-repo/postfix/sasl_passwd /etc/postfix/sasl_passwd

echo ""

echo Compiling lookup databases
echo Compiling SASL Password
postmap hash:/etc/postfix/sasl_passwd

echo Compiling Virtual Lookups
postmap /etc/postfix/virtual/*

echo Starting Postfix...
service postfix start
