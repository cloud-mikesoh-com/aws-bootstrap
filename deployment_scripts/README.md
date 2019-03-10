# Deploying this repository

This script relies upon private repositories and assumes that the ssh
key it is assigned can pull from those private repositories.

This `README` is provided to track the current version of the Ubuntu AMI
that is used in the `[ec2_t3-micro.json](ec2_t3-micro.json)` file.  Since 
Amazon does not keep track of historical AMIs, it's left to third parties.  
Fortunately, [Ubuntu has a website dedicated to their AMIs](https://cloud-images.ubuntu.com/locator/ec2/).

All AMIs are provided in the `us-east-1` availability zone.

Currently, this deployment script uses the following AMI:

* AMI ID: ami-0a313d6098716f372
* Name: bionic beaver
* Version: 18.04 LTS amd64
* Instance Type: hvm:ebs-ssd
* Release date: 20190212.1

In theory, you should be able to use this script against any current
Ubuntu AMI, but it is tested against the image listed above.
