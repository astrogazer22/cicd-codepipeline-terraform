#!/bin/bash
yum update -y
yum install -y ruby wget
cd /home/ec2-user
wget https://aws-codedeploy-${var.aws_region}.s3.${var.aws_region}.amazonaws.com/latest/install
chmod +x ./install
./install auto
