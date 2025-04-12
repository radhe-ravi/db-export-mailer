send_email() {
  local CURRENT_DATE="$1"
  local URL="$2"

  # Define the email body content
  local EMAIL_HTML="<p>Hello,</p><p>Attached is the ZIP file containing all master exports:</p><p><a href='${URL}'>Download Export ZIP</a></p>"
  local EMAIL_TEXT="Hello,\n\nAttached is the ZIP file containing all master exports:\n${URL}"

  # Prepare the JSON payload
  local EMAIL_PAYLOAD=$(cat <<EOF
{
  "clientId": "local",
  "inputs": {
    "notificationType": "email",
    "notificationParameters": [
      { "key": "notificationMessageType", "value": "TRANS" },
      { "key": "subject", "value": "Master Data Export - ${CURRENT_DATE}" }
    ],
    "notificationListParameters": [
      {
        "fromEmailAddress": {
          "key": "from",
          "value": [
            { "emailId": "${FROM_EMAIL}", "name": "Effigo" }
          ]
        },
        "emailBody": [
          {
            "key": "content",
            "value": [
              { "type": "text/plain", "value": "${EMAIL_TEXT}" },
              { "type": "text/html", "value": "${EMAIL_HTML}" }
            ]
          }
        ],
        "recipients": [
          {
            "key": "to",
            "value": [
              { "emailId": "${TO_EMAIL}", "name": "IT" }
            ]
          }
        ]
      }
    ]
  }
}
EOF
  )

  # Log the payload to help with debugging
  log_info "Sending email with the following payload: $EMAIL_PAYLOAD"

  # Send the email request via API
  local RESPONSE=$(curl -s -w "%{http_code}" -o /tmp/mail_response.txt \
    --location "$API_URL" \
    --header 'Content-Type: application/json' \
    --data-raw "$EMAIL_PAYLOAD")

  # Log the complete response for debugging purposes
  log_info "API response: $(cat /tmp/mail_response.txt)"

  # Check the response code and handle errors
  if [[ "$RESPONSE" == "200" ]]; then
    log_info "✅ Email sent successfully to ${TO_EMAIL}."
  else
    log_error "❌ Failed to send email. Status code: $RESPONSE. Response: $(cat /tmp/mail_response.txt)"
    exit 1
  fi
}
