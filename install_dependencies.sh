#!/bin/bash
set -e

# Update system
sudo yum update -y

# Install Node.js 16
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# Install pm2 to run Node apps
sudo npm install -g pm2

echo "Dependencies installed successfully."
