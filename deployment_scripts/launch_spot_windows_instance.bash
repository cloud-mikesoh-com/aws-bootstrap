#!/bin/bash

FILE=./windows.ps
LAUNCH_CONFIG=./ec2-windowsServer2019-t3-medium.json

run_me () {
    USERDATA=`cat ${FILE} | base64 -w 0`

    if [ -e tmp.json ]; then
        rm tmp.json
    fi

    echo Generating userdata...
    sed -r 's/\"\$USERDATA\"/\"'"${USERDATA}"'\"/' ./${LAUNCH_CONFIG} > tmp.json

    echo Requesting spot instance...
    aws ec2 request-spot-instances --spot-price 0.03 --type "one-time" \
        --launch-specification file://tmp.json

    rm tmp.json
}


if [ -z ${1} ]; then
    echo "No parameter provided.  Default is ${FILE}".
elif [ ! -f ${1} ]; then
    echo "usage: ${0} <filename of userdata script to run at instance creation>"
    exit 1
else
    FILE=${1}
fi

run_me
