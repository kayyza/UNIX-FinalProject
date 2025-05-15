# INSTALL.md

## Project Setup Instructions

This document details the steps completed to configure the project.

---

## 1. VPS Creation

### Provider
- **Chosen Provider:** DigitalOcean

### Droplet Configuration
- **Image:** Ubuntu 22.04 (LTS)
- **Region:** nyc1 (or close to target users)
- **Authentication:** SSH key (generated on local machine and added during droplet setup)
- **Size:** Basic Shared CPU (1GB RAM)

---

## 2. SSH Key Setup (Local Machine)

### Generate SSH Key

```ssh-keygen ``` 

Public key: ~/.ssh/id_rsa.pub \
Private key: ~/.ssh/id_rsa

**Add Public Key to Droplet via DigitalOcean Dashboard**

## 3. Connect to Droplet
### Test Connection as root:

```ssh root@<droplet-ip>```

Replace <droplet-ip> with your actual Droplet IP.

## 4. Create a Non-Root User (deploy)
### Add User

```adduser deploy```

Created a user named deploy for deployment and management tasks.

### Grant Sudo Access

```usermod -aG sudo deploy```

Allowed deploy to run commands with sudo privileges.

## 5. Configure SSH Access for deploy
### As root user:

```mkdir /home/deploy/.ssh```
```nano /home/deploy/.ssh/authorized_keys```

Paste your public key into authorized_keys.

```chown -R deploy:deploy /home/deploy/.ssh```
```chmod 700 /home/deploy/.ssh```
```chmod 600 /home/deploy/.ssh/authorized_keys```

Set proper ownership and permissions for secure access.

### Test SSH login as deploy:

```ssh deploy@<droplet-ip>```

## 6. File Permissions Verification
### Check permissions:

```ls -ld /home/deploy```
```ls -l /home/deploy/.ssh```

Verified that the .ssh directory and key file have secure permissions.
Ensured only deploy can access SSH credentials.

## 7. Install and Configure Nginx

### Install Nginx
```bash
sudo apt update
sudo apt install nginx -y
```

### Start and Enable Nginx
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```
### Create Custom Site Configuration
```bash
sudo nano /etc/nginx/sites-available/mywebsite
```

Example config:
```
server {
    listen 80;
    server_name localhost;

    root /var/www/mywebsite;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

### Enable the Site
```bash
sudo ln -s /etc/nginx/sites-available/mywebsite /etc/nginx/sites-enabled/
```

### Create Web Directory
```bash
sudo mkdir -p /var/www/mywebsite
sudo chown -R $USER:$USER /var/www/mywebsite
```

### Test Configuration and Reload Nginx
```bash
sudo nginx -t
sudo systemctl reload nginx
```
## 8. Clone the Project Repository

Clone your GitHub repository into the appropriate web directory:

```bash
cd /var/www
sudo git clone https://github.com/your-username/yourProject.git
```

Set the correct ownership:
``` bash
sudo chown -R www-deploy:www-deploy /var/www/yourProject
```

## 9. Configure Nginx to Serve the Cloned Project
Update your Nginx site configuration:
``` bash
sudo nano /etc/nginx/sites-available/mywebsite
```
Update the contents of this file:
``` bash
server {
    listen 80;
    server_name localhost;

    root /var/www/yourProject;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

Reload Nginx:
``` bash
sudo systemctl reload nginx
```
10. Write a Deployment Script

Create a shell script that pulls the latest changes from the repository.
``` bash
sudo nano /var/www/UNIX-FinalProject/Bash/10_update_website.sh
```

Paste the following into the file:
``` bash
#!/bin/bash

cd /var/www/UNIX-FinalProject
git reset --hard
git pull origin main

Make the script executable:

chmod +x /var/www/UNIX-FinalProject/Bash/10_update_website.sh
```

## 11. Set Up Cron Job for Auto-Deployment
Create a cron job to pull the latest changes from GitHub every minute.



1. Create a new cron file:
``` bash
sudo nano /etc/cron.d/project_maintenance
```
2. Edit the file with this code:
``` bash
* * * * * root /bin/bash /var/www/UNIX-FinalProject/Bash/10_update_website.sh >> /var/log/deploy.log 2>&1
```
3. Restart the cron service:
``` bash
sudo systemctl restart cron
```

## 12. Make the Deployment Script Executable
Ensure your deployment script has the proper permissions:

``` bash
chmod +x /var/www/UNIX-FinalProject/Bash/10_update_website.sh
```
## 13. Test the cron job
Manually test the deployment script:
```bash 
/bin/bash /var/www/UNIX-FinalProject/Bash/10_update_website.sh
```
You can then check the deployment log:
```bash
cat /var/log/deploy.log
```
Push a change to your GitHub repository and verify that the update appears on the site
