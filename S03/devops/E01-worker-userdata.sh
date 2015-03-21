#!/bin/bash

curl -sL https://rpm.nodesource.com/setup | bash -
yum -y install gcc-c++ make git nodejs
npm install forever initd-forever -g
git clone https://github.com/AWSHubBR/devops-aws /opt/devops-aws


