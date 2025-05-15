#!/bin/bash

#REPO_DIR="/home/deployuser/UNIX-FinalProject"
#SITE_DIR="$REPO_DIR/[insert site here]"
#MIRROR_URL="https://sr-delightfully.github.io/portfolio-2023/"
#LOG_FILE="/var/log/deploy.log"

REPO_DIR="$1"
SITE_DIR="$2"
MIRROR_URL="$3"
WEBSITE_NAME="$4"
PORT="$5"
LOG_FILE="/var/log/deploy.log"

RED='\033[1;91m'
GREEN='\033[1;32m'
NC='\033[0m'

exec > >(tee -i $LOG_FILE)
exec 2>&1

cd $REPO_DIR || {
        echo -e "${RED} [❗ERROR❗] Failed to access the repository's directory ${NC}";
        exit 1;
}


#--> Clearing existing site content
rm -rf $SITE_DIR && mkdir -p $SITE_DIR || {
        echo -e "${RED} [❗ERROR❗] Failed to reset the site's directory ${NC}"
}

#--> Attempting to mirror website from $MIRROR_URL
wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $MIRROR_URL -P $SITE_DIR || {
        echo -e "${RED} [❗ERROR❗] Failed to mirror the website ${NC}";
        exit 1;
}

#--> Moving site files
mv $SITE_DIR/sr-delightfully.github.io/portfolio-2023/* $SITE_DIR/ || { #shouldn't this be the URL to mirror?
        echo -e "${RED} [❗ERROR❗] Failed to move site files ${NC}";
        exit 1;
}.
rm -rf $SITE_DIR/sr-delightfully.github.io/portfolio-2023/ #shouldn't this be the URL to mirror?

echo "Building Docker image for ${WEBSITE_NAME}…"

IMAGE_NAME="${WEBSITE_NAME}_image"
CONTAINER_NAME="${WEBSITE_NAME}_container"


docker build -t "$IMAGE_NAME" "$SITE_DIR" || { #Building the image from the Dockerfile in $SITE_DIR
  echo -e "${RED} [❗ERROR❗] Failed to build Docker image ${NC}";
  exit 1;
}

docker rm -f "$CONTAINER_NAME" 2>/dev/null || true #removes all container with the same name

docker run -d \
  --name "$CONTAINER_NAME" \
  -p "$PORT":80 \
  "$IMAGE_NAME" 
  
  || {
    echo -e "${RED} [❗ERROR❗] Failed to start Docker container ${NC}";
    exit 1;
    }

echo -e "${GREEN} Deployed completed '$CONTAINER_NAME' serving at http://localhost:${PORT} ${NC}"

# For more information see: "https://docs.docker.com/compose/"
# and see: "https://www.gnu.org/software/wget/manual/wget.html"