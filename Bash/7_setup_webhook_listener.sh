#!/bin/bash

WEBHOOK_DIR="/opt/webhook"
LISTENER_SCRIPT="$WEBHOOK_DIR/webhook_listener.py"
SERVICE_NAME="webhook-listener"

echo "Creating directory"
sudo mkdir -p $WEBHOOK_DIR
sudo chown $USER:$USER $WEBHOOK_DIR

# Alternatively, we could also use the following code:
#
# ` while true; do
#       echo -e "HTTP/1.1 200 OK\r\n\r\nWebhook recieved" | nc -1 -p 9000 >> /opt/webhook/payload.log
#   done `
#
# just remove the backticks and hashtags to uncomment the code!