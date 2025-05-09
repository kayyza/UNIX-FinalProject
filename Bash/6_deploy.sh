REPO_DIR="/home/deployuser/UNIX-FinalProject"
SITE_DIR="$REPO_DIR/site"
MIRROR_URL="https://sr-delightfully.github.io/portfolio-2023/"

cd $REPO_DIR

echo "Clearing existing site content"
rm -rf $SITE_DIR
mkdir -p $SITE_DIR

echo "Mirroring website from $MIRROR_URL"
wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $MIRROR_URL -P $SITE_DIR

mv $SITE_DIR/sr-delighftully.github.io/portfolio-2023/*$SITE_DIR/
rm -rf $SITE_DIR/sr-delightfully.github.io/portfolio-2023/

echo "Rebuilding and restarting containers"
docker-compose down
docker-compose up -d --build

echo "deployment completed"