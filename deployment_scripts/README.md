# Deploying this repository

This script relies upon private repositories and assumes that the ssh
key it is assigned can pull from those private repositories.

This `README` is provided to track the current version of the Ubuntu AMI
that is used in the `[ec2_t3-micro.json](ec2_t3-micro.json)` file.  Since 
Amazon does not keep track of historical AMIs, it's left to third parties.  
Fortunately, [Ubuntu has a website dedicated to their AMIs](https://cloud-images.ubuntu.com/locator/ec2/).

All AMIs are provided in the `us-east-1` availability zone.

Currently, this deployment script uses the following AMI:

* AMI ID: ami-0dd76f917833aac4b
* Name: focal fossa
* Version: 20.04 LTS amd64
* Instance Type: hvm:ebs-ssd
* Release date: 20210621

In theory, you should be able to use this script against any current
Ubuntu AMI, but it is tested against the image listed above.

# IAM Permissions

In order to use the `launch_spot_instance.bash` file, you must have an AWS
API key.  The policy requirements are listed on [AWS's EC2 
documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-requests.html).

They have been copied here for convienence:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:RunInstances",
                "ec2:CreateTags",
                "ec2:RequestSpotFleet",
                "ec2:ModifySpotFleetRequest",
                "ec2:CancelSpotFleetRequests",
                "ec2:DescribeSpotFleetRequests",
                "ec2:DescribeSpotFleetInstances",
                "ec2:DescribeSpotFleetRequestHistory"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "arn:aws:iam::*:role/aws-ec2-spot-fleet-tagging-role"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole",
                "iam:ListRoles",
                "iam:ListInstanceProfiles"
            ],
            "Resource": "*"
        }
    ]
}
```

The `aws-ec2-spot-fleet-tagging-role` is automatically created when you request
EC2 spot instances through the AWS console.  The same documentation above provides
instructions on how to create this on your own.
