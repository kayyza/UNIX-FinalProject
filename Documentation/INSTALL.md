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


