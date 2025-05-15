#!/bin/bash 

RED='\033[1;91m'
ORANGE='\033[0;33m]'
GREEN='\033[1;32m'
NC='\033[0m'

LOG_FILE="/var/log/firewall_setup.log"
exec > >(tee -i $LOG_FILE)
exec 2>&1

#--> Setting up the Firewall

if ! command -v ufw &> /dev/null; then
    echo -e "${ORANGE} [⚠️ WARNING ⚠️] UFW not found. To avoid potential conflicts the system will now attempt to install UFW ${NC}"
    sudo apt update && sudo apt install -y ufw || {
        echo -e "${RED} [❗ERROR❗] Failed to install UFW ${NC}";
        exit 1;
    }
fi

#--> Setting default policies:
sudo ufw default deny incoming || exit 1
sudo ufw default allow outgoing || exit 1

#--> Allowing essential ports to remain open:
sudo ufw allow 22/tcp || {
        echo -e "${RED} [❗ERROR❗] Failed to allow SSH ${NC}";
        exit 1;
}
sudo ufw allow 80/tcp || {
        echo -e "${RED} [❗ERROR❗] Failed to allow HTTP ${NC}";
        exit 1;
}

#--> Enabling firewall
sudo ufw --force enable || {
        echo -e "${RED} [❗ERROR❗] Failed to enable UFW ${NC}";
        exit 1;
}

echo "Status of firewall:"
sudo ufw status verbose
echo -e "${GREEN} [ SUCCES ✅] UFW firewall configured successfully. Only ports 22 and 80 are open. ${NC}"

# For more information see: "https://help.ubuntu.com/community/UFW"
# or simply run the command `man ufw`!