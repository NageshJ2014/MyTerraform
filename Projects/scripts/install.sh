#!/bin/bash
sudo apt-get update -y
sudo apt-get install apache2 -y
service apache2 start
sudo apt-get install python-pip -y

sudo  pip install awscli
sudo apt-get install nfs-common -y
sudo apt-get install python-pip awscli -y

sudo  pip install awscli
