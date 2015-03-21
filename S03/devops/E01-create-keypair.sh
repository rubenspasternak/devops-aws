#!/bin/bash
KEYNAME="devopskp" 
aws ec2 create-key-pair --key-name ${KEYNAME} --query="KeyMaterial" --output=text > ${KEYNAME}.pem
chmod 400 ${KEYNAME}.pem