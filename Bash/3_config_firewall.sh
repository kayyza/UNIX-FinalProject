#!/bin/bash 

LOG_FILE="/var/log/firewall_setup.log"
exec > >(tee -i $LOG_FILE)
exec 2>&1

#--> Setting up the Firewall

if ! command -v ufw &> /dev/null; then
    echo "[⚠️ WARNING ⚠️] UFW not found. To avoid potential conflicts the system will now attempt to install UFW"
    sudo apt update && sudo apt install -y ufw || {
        echo "[❗ERROR❗] Failed to install UFW";
        exit 1;
    }
fi

#--> Setting default policies:
sudo ufw default deny incoming || exit 1
sudo ufw default allow outgoing || exit 1

#--> Allowing essential ports to remain open:
sudo ufw allow 22/tcp || {
        echo "[❗ERROR❗] Failed to allow SSH";
        exit 1;
}
sudo ufw allow 80/tcp || {
        echo "[❗ERROR❗] Failed to allow HTTP";
        exit 1;
}

#--> Enabling firewall
sudo ufw --force enable || {
        echo "[❗ERROR❗] Failed to enable UFW";
        exit 1;
}

echo "Status of firewall:"
sudo ufw status verbose
echo "[ SUCCES ✅] UFW firewall configured successfully. Only ports 22 and 80 are open."

# For more information see: "https://help.ubuntu.com/community/UFW"
# or simply run the command `man ufw`!