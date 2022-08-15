#!/bin/bash -xe

echo "Installing MariaDB --Client--"

DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-client

mariadb --version

echo Done.
