USERDATA=`cat ../userdata.sh | base64 -w 0`

if [ -e tmp.json ]; then
    rm tmp.json
fi

echo Generating userdata...
sed -r 's/\"\$USERDATA\"/\"'"${USERDATA}"'\"/' ./ec2_t3-micro.json > tmp.json

echo Requesting spot instance...
aws ec2 request-spot-instances --spot-price 0.0116 --type "one-time" \
    --launch-specification file://tmp.json

