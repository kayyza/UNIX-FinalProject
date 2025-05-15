#!/bin/bash

WEB_DIR="/var/www/html"
DEPLOY_USER="$1" #"deployuser"
GREEN='\033[1;32m'
NC='\033[0m'

# Setting ownership/permissions for the web directory

sudo chown -R $DEPLOY_USER:www-data $WEB_DIR=
sudo chmod -R 755 $WEB_DIR

echo -e "${GREEN} Permissions have been set sucessfully ${NC}"

# For more information see: "https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-permissions"
# And see: "https://www.redhat.com/en/blog/linux-file-permissions-explained"
# or simply run the commands `man chown` and `man chmod`!  