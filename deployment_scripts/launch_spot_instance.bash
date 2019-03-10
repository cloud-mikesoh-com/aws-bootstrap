#!/bin/bash

FILE=../userdata.sh

run_me () {
    USERDATA=`cat ${FILE} | base64 -w 0`

    if [ -e tmp.json ]; then
        rm tmp.json
    fi

    echo Generating userdata...
    sed -r 's/\"\$USERDATA\"/\"'"${USERDATA}"'\"/' ./ec2_t3-micro.json > tmp.json

    echo Requesting spot instance...
    aws ec2 request-spot-instances --spot-price 0.0116 --type "one-time" \
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
