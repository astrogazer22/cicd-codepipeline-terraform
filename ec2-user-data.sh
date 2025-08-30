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

yum update -y 
amazon-linux-extras enable nginx1 
yum install -y nginx 
systemctl start nginx 
systemctl enable nginx
echo "<h1>Deployed with Terraform & CodeDeploy</h1>" > /usr/share/nginx/html/index.html
