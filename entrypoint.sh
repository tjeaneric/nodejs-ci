#!/bin/bash

# Replace with your target host and port
TARGET_HOST="message-service"
TARGET_PORT="8080"

# Make the request (adjust method, headers, etc. as needed)
curl -f -o /dev/null -w "%{http_code}" "http://${TARGET_HOST}:${TARGET_PORT}/messages" RESPONSE_CODE=$?

# Check the response code and log the result
if [[ $RESPONSE_CODE -eq 200 ]]; then
  echo "Request to /messages successful."
else
  echo "Error: Request to /messages failed with code: $RESPONSE_CODE"
fi
