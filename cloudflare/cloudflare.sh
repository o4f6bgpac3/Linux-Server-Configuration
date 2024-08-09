#!/bin/bash

# Load variables from config.txt
source ./config.txt

# Get the current IP of the server
CURRENT_IP=$(curl -s http://ipv4.icanhazip.com)

# Get the IP of the A record from Cloudflare
RECORD_IP=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${RECORD_ID}" \
  -H "Authorization: Bearer ${API_TOKEN}" \
  -H "Content-Type: application/json" | jq -r '.result.content')

# Compare the two IPs
if [ "$CURRENT_IP" != "$RECORD_IP" ]; then
  echo "IP has changed, updating Cloudflare A record."

  # Update the Cloudflare A record
  UPDATE_RESULT=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${RECORD_ID}" \
    -H "Authorization: Bearer ${API_TOKEN}" \
    -H "Content-Type: application/json" \
    --data '{"type":"A","name":"'"$DOMAIN"'","content":"'"$CURRENT_IP"'","ttl":120,"proxied":false}' | jq -r '.success')

  if [ "$UPDATE_RESULT" = "true" ]; then
    echo "A record updated successfully."
  else
    echo "Failed to update A record."
  fi
else
  echo "IP has not changed, no update needed."
fi