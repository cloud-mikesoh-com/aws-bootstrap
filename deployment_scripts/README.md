# Deploying Instances

This bootstrap repository deploys primarily an Ubuntu Server instance.
However, I've started playing around a Windows Server 2019 instance. 

All AMIs are provided in the `us-east-1` availability zone.

# Ubuntu Linux

This script relies upon private repositories and assumes that the ssh
key it is assigned can pull from those private repositories.

This `README` is provided to track the current version of the Ubuntu AMI
that is used in the `[ec2-ubuntu-t3-micro.json](ec2-ubuntu-t3-micro.json)` 
file.  Since Amazon does not keep track of historical AMIs, it's left to 
third parties.  Fortunately, [Ubuntu has a website dedicated to their 
AMIs](https://cloud-images.ubuntu.com/locator/ec2/).

Currently, this deployment script uses the following AMI:

* AMI ID: ami-0a313d6098716f372
* Name: bionic beaver
* Version: 18.04 LTS amd64
* Instance Type: hvm:ebs-ssd
* Release date: 20190212.1

In theory, you should be able to use this script against any current
Ubuntu AMI, but it is tested against the image listed above.


# Windows Server 2019

The windows deployment script doesn't do much right now.  But at
current, the deployment script uses the following AMI:

* AMI ID: ami-032c2c4b952586f02
* Name: Windows_Server-2019-English-Full-Base-2020.08.12
* Creation Date: August 12, 2020 at 12:55:38 AM UTC-4

