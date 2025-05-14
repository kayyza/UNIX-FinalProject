#!/bin/bash

# Navigate to the website directory
cd /var/www/mywebsite

# Pull the latest changes from Git repository
git pull origin main

# Restart Nginx to reflect the changes
sudo systemctl restart nginx
