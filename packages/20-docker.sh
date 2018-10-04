#!/bin/bash

echo Installing docker and docker-compose
DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    docker-ce \
    docker-compose
