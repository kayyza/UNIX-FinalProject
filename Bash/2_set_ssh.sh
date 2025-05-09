DEPLOY_USER="deployuser"

echo "Creating a new sudo user named $DEPLOY_USER"
sudo adduser $DEPLOY_USER
sudo usermod -aG sudo $DEPLOY_USER

echo "Setting up SSH key authentication for $DEPLOY_USER"
sudo mkdir -p /home/$DEPLOY_USER/.ssh
sudo cp ~/.ssh/authorized_keys /home/$DEPLOY_USER/.ssh/
sudo chown -R $DEPLOY_USER:$DEPLOY_USER /home/$DEPLOY_USER/.ssh
sudo chmod 700 /home/$DEPLOY_USER/.ssh
sudo chmod 600 /home/$DEPLOY_USER/.ssh/authorized_keys

echo "Disabling password login"
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl reload sshd

echo "SSH haandling complete."