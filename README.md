# mikesoh.com AWS Configuration

I got tired of manually installing a bunch of stuff into my EC2 instance
so I created a bootstrap file that can be run [upon
launch](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html).

You are welcome to run this yourself if you're interested in running a
packaged AWS instance.  To do so, add the following lines into your
instance's "User Data" prompt:

```
!#/bin/bash
bash <(curl -s https://raw.githubusercontent.com/sohmc/aws-bootstrap/master/bootstrap.sh)
```


## Run Conditions

This repository assumes you are running an Ubuntu AMI as it heavily uses
`apt-get` to install various packages.  It has not been tested against
any other debian flavor but I would assume that it works.


## Packages

Files with the `.sh` file extension within the `packages/` will get 
processed by the bootstrap script.  You must ensure that your package
file is written in `bash`.

It is highly recommended that you utilize version numbers to ensure that
you will have a consistant running instance.  You can find the version
numbers of apt packages by searching [Ubuntu's `apt` Package
Database](https://packages.ubuntu.com).

The following packages will be installed:

* MySQL 5.7


## Individual Packages

If you want to install individual packages where you always need the
latest version and does not require configuration (e.g. git, wget,
python), you can either create a `.sh` file within packages or add them
to the main `bootstrap.sh` file.  The benefit of putting individual
packages within the main file is that these packages will get installed
before any other packages.


## License

All scripts within this repository are released under the MIT License.

All Documentation within this repository are released under the CC-BY
License.
