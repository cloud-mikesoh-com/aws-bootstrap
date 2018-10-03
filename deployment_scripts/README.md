# Deploying this repository

This script relies upon private repositories and assumes that the ssh
key it is assigned can pull from those private repositories.

This `README` is provided to track the current version of the Ubuntu AMI
that is used in the `ec2_t2-micro.json` file.  Since Amazon does not
keep track of historical AMIs, it's left to third parties.  Fortunately,
[Ubuntu has a website dedicated to their
AMIs](https://cloud-images.ubuntu.com/locator/ec2/).

Currently, this deployment script uses the following AMI:

* AMI ID: ami-0ac019f4fcb7cb7e6
* Name: bionic beaver
* Version: 18.04 LTS amd64
* Instance Type: hvm:ebs-ssd
* Release date: 20180912

In theory, you should be able to use this script against any current
Ubuntu AMI, but it is tested against the above details.