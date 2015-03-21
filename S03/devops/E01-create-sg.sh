#!/bin/bash
SGNAME=devops_app-worker

aws ec2 create-security-group \
  --group-name $SGNAME \
  --description "express.js app worker security group"

aws ec2 authorize-security-group-ingress \
  --group-name $SGNAME \
   --protocol tcp \
   --port 3000 \
   --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
  --group-name $SGNAME \
   --protocol tcp \
   --port 22 \
   --cidr 0.0.0.0/0