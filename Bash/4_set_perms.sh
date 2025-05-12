#!/bin/bash

WEB_DIR="/var/www/html"
DEPLOY_USER="deployuser"

# Setting ownership/permissions for the web directory

sudo chown -R $DEPLOY_USER:www-data $WEB_DIR=
sudo chmod -R 755 $WEB_DIR

echo "Permissions have been set sucessfully"

# For more information see: "https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-permissions"
# And see: "https://www.redhat.com/en/blog/linux-file-permissions-explained"
# or simply run the commands `man chown` and `man chmod`!  