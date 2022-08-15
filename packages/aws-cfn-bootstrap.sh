#!/bin/bash -xe

#### VARIABLE DECLARATION ####
PACKAGE_VERSION='1.0.0'

echo Installing aws-cfn-bootstrap
curl https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-py3-latest.tar.gz -o /tmp/aws-cfn-bootstrap.tar.gz

mkdir -p /opt/aws/bin
python3 -m easy_install --script-dir /opt/aws/bin /tmp/aws-cfn-bootstrap.tar.gz

