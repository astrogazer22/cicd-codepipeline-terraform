#!/bin/bash
yum update -y
yum install -y ruby wget

# Download the CodeDeploy agent installer for ap-southeast-1
cd /home/ec2-user
wget https://aws-codedeploy-ap-southeast-1.s3.ap-southeast-1.amazonaws.com/latest/install
chmod +x ./install
./install auto

# Enable and start the agent
systemctl enable codedeploy-agent
systemctl start codedeploy-agent
