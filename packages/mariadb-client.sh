#!/bin/bash -xe

echo "Installing MariaDB --Client--"

apt-get install -y mariadb-client

mariadb --version

echo Done.
