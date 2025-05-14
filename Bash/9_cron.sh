#!/bin/bash

CRON_FILE="/etc/cron.d/project_maintenance"

# Creating cron job file at $CRON_FILE

sudo tee $CRON_FILE > /dev/null <<EOF

# SSL certificate renewal should run daily at 2:30am
30 2 * * * root certbot renew --quiet

# Daily backup at 3:00am
0 3 * * * root /bin/bash /path/to/8_backup.sh >> /var/log/backup.log 2>&1
EOF

echo "The Cron services are reloading"
sudo systemctl reload cron

echo "Cron jobs has been installed"

# For more information see: "https://help.ubuntu.com/community/CronHowto"
# and see: "https://crontab.guru/"
