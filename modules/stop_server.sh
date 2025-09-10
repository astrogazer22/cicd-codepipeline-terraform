#!/bin/bash
set -e

echo "Stopping Node.js server..." >> /home/ec2-user/stop_server.log

# Try to stop Node.js processes; ignore errors if none found
pkill -f server.js || echo "No server process found"

# Optional: wait a few seconds for cleanup
sleep 5

echo "ApplicationStop completed successfully"
exit 0
