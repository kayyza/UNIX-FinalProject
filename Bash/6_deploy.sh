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
mv $SITE_DIR/sr-delightfully.github.io/portfolio-2023/* $SITE_DIR/ || { #shouldn't this be the URL to mirror?
        echo "[❗ERROR❗] Failed to move site files";
        exit 1;
}.
rm -rf $SITE_DIR/sr-delightfully.github.io/portfolio-2023/ #shouldn't this be the URL to mirror?

echo "Building Docker image for ${WEBSITE_NAME}…"

IMAGE_NAME="${WEBSITE_NAME}_image"
CONTAINER_NAME="${WEBSITE_NAME}_container"


docker build -t "$IMAGE_NAME" "$SITE_DIR" || { #Building the image from the Dockerfile in $SITE_DIR
  echo "[❗ERROR❗] Failed to build Docker image";
  exit 1;
}

docker rm -f "$CONTAINER_NAME" 2>/dev/null || true #removes all container with the same name

docker run -d \
  --name "$CONTAINER_NAME" \
  -p "$PORT":80 \
  "$IMAGE_NAME" 
  
  || {
    echo "[❗ERROR❗] Failed to start Docker container";
    exit 1;
    }

echo "Deployed completed '$CONTAINER_NAME' serving at http://localhost:${PORT}"

# For more information see: "https://docs.docker.com/compose/"
# and see: "https://www.gnu.org/software/wget/manual/wget.html"