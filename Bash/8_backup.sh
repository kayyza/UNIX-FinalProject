#!/bin/bash

BACKUP_DIR="/opt/backups"
TIMESTAMP=$(date + "%F_%T")
ARCHIVE_NAME="backup_$TIMESTAMP.tar.gz"

# Creating bacup directory if it doesn't already exist
mkdir -p $BACKUP_DIR

# Actually backing up the html and docker volumes
tar -czvf $BACKUP_DIR/$ARCHIVE_NAME /var/www/html /var/lib/docker/volumes

echo "Backup has been created at the following location: $BACKUP_DIR/$ARCHIVE_NAME"

# For more information see: "https://linuxize.com/post/how-to-create-and-extract-archives-using-the-tar-command-in-linux/"
# and see: "https://tldp.org/LDP/Bash-Beginners-Guide/html/"