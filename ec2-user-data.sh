#!/bin/bash 
yum update -y 
amazon-linux-extras enable nginx1 
yum install -y nginx 
systemctl start nginx 
systemctl enable nginx
echo "<h1>Deployed with Terraform & CodeDeploy</h1>" > /usr/share/nginx/html/index.html
