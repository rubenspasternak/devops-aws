#!/bin/bash

USRPWD="MUDEME"

# Install Git
yum -y install git httpd php

# Adds remote user
useradd fulano
echo $USRPWD | passwd fulano --stdin

# Opens web console with password authentication
# *** Don't do this at home **
sed -i.bak 's/^.*PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i.bak 's/^.*PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/ssh_config
service sshd reload
wget https://github.com/nickola/web-console/releases/download/v0.9.5/webconsole-0.9.5.zip -O /opt/webconsole-0.9.5.zip
unzip /opt/webconsole-0.9.5.zip -d /var/www/html/
service httpd start
chkconfig httpd on
# 
sudo -u fulano git clone https://github.com/AWSHubBR/devops-aws.git ~/devops-aws

