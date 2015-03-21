#!/bin/bash

curl -sL https://rpm.nodesource.com/setup | bash -
yum -y install gcc-c++ make git nodejs
npm install forever initd-forever -g
useradd -m -d /home/node node

git clone https://github.com/AWSHubBR/devops-aws /opt/devops-aws
ln -s /opt/devops-aws/devops_app/init/devops_app /etc/init.d/devops_app
chmod +x /etc/init.d/devops_app

