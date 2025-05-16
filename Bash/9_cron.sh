#!/bin/bash

CRON_FILE="/etc/cron.d/project_maintenance"

# Creating cron job file at $CRON_FILE
sudo tee $CRON_FILE > /dev/null <<EOF
# Run auto-deployment every minute
* * * * * root /bin/bash /var/www/UNIX-FinalProject/Bash/10_update_website.sh >> /var/log/deploy.log 2>&1
EOF

echo "Reloading cron service"
sudo systemctl restart cron

echo "Cron jobs installed and running every minute"
