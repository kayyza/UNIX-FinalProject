REM "Setting up the Firewall"
echo "Configuring Firewall"
sudo ufw allow OpenSSH
sudo ufw allow http
sudo ufw allow https

echo "Enabling firewall"
sudo ufw --force enable

echo "Status of firewall"
sudo ufw status verbose