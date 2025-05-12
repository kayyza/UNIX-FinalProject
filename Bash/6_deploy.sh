#!/bin/bash

REPO_DIR="/home/deployuser/UNIX-FinalProject"
SITE_DIR="$REPO_DIR/[insert site here]"
MIRROR_URL="https://sr-delightfully.github.io/portfolio-2023/"
LOG_FILE="/var/log/deploy.log"

exec > >(tee -i $LOG_FILE)
exec 2>&1

cd $REPO_DIR || {
        echo "[❗ERROR❗] Failed to access the repository's directory";
        exit 1;
}


#--> Clearing existing site content
rm -rf $SITE_DIR && mkdir -p $SITE_DIR || {
        echo "[❗ERROR❗] Failed to reset the site's directory"
}

#--> Attempting to mirror website from $MIRROR_URL
wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $MIRROR_URL -P $SITE_DIR || {
        echo "[❗ERROR❗] Failed to mirror the website";
        exit 1;
}

#--> Moving site files
mv $SITE_DIR/sr-delightfully.github.io/portfolio-2023/* $SITE_DIR/ || {
        echo "[❗ERROR❗] Failed to move site files";
        exit 1;
}
rm -rf $SITE_DIR/sr-delightfully.github.io/portfolio-2023/

echo "Rebuilding and restarting containers"
docker-compose down
docker-compose up -d --build

echo "deployment completed"

# For more information see: "https://docs.docker.com/compose/"
# and see: "https://www.gnu.org/software/wget/manual/wget.html"