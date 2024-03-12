#!/bin/bash

# Replace 'YOUR_WEBHOOK_URL' with your actual Discord webhook URL
WEBHOOK_URL=$DISCORD_NOTIFICATIONS_WEBHOOK_URL

# Message to send
MESSAGE="<@$DISCORD_USER_ID> $1"

# Create JSON payload
JSON="{\"content\":\"$MESSAGE\"}"

# Send the POST request to the webhook URL
curl -H "Content-Type: application/json" -d "$JSON" "$WEBHOOK_URL"
