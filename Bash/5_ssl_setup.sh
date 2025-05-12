#!/bin/bash

DOMAIN="[insert-domain-here.com]"
EMAIL="admin@insert-domain-here.com"

# Installing CertBot and SSL dependencies
sudo apt update
sudo apt install -y certbot python3-certbot-nginx

# Obtaining SSL certificate for $DOMAIN
sudo certbot --ngin -d $DOMAIN --non-interactive --agree-tod -m $EMAIL

# Verifying certificate renewal
sudo certbot renew --dry-run

# For more information see: "https://certbot.eff.org/instructions?ws=nginx&os=snap"
# and see: "https://eff-certbot.readthedocs.io/en/stable/using.html#certbot-command-line-options"