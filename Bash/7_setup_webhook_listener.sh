WEBHOOK_DIR="/opt/webhook"
LISTENER_SCRIPT="$WEBHOOK_DIR/webhook_listener.py"
SERVICE_NAME="webhook-listener"

echo "Creating directory"
sudo mkdir -p $WEBHOOK_DIR
sudo chown $USER:$USER $WEBHOOK_DIR
