#!/bin/bash

# Setup
useradd -m -d /home/node node
curl -sL https://rpm.nodesource.com/setup | bash -
yum -y install gcc-c++ make git nodejs
npm install forever initd-forever -g

# Setup devops_app
git clone https://github.com/AWSHubBR/devops-aws /opt/devops-aws
npm install -g /opt/devops-aws/devops_app
ln -s /opt/devops-aws/devops_app/init/devops_app /etc/init.d/devops_app
chmod +x /etc/init.d/devops_app

