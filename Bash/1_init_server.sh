REM "Initializing the server, upgrading and updating"

echo "Updating system packages"
sudo apt update && sudo apt upgrade -y

echo "Installing project packages"
sudo apt install -y curl wget git ufw nginx docker.io docker-compose

echo "Enabling docker to start on boot"
sude systemctl enable docker
sudo systemctl start docker

echo "Adding current use to docker group"
sude uermod -aG docker $USER

echo "Server initialized, please re-login without sudo"