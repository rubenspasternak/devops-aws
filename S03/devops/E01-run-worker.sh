#!/bin/bash -e

# http://aws.amazon.com/pt/amazon-linux-ami/
AMI="ami-146e2a7c"
KEYNAME="devopskp" 
SGNAME="devops_app-worker"

echo "Requesting instance"
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI \
  --count 1 \
  --instance-type t2.micro \
  --key-name $KEYNAME \
  --security-groups $SGNAME \
  --user-data file://./E01-worker-userdata.sh \
  --query "Instances[0].InstanceId" \
  --output text)

echo "Waiting for $INSTANCE_ID to be running"
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

echo "Fetching public ip for $INSTANCE_ID"
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

echo "Worker should soon be up at http://${PUBLIC_IP}:3000"