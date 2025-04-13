send_email() {
  local CURRENT_DATE="$1"
  local FILE_PATH="$2"

  log_info "Preparing to send email with attachment: $FILE_PATH"

  RESPONSE=$(curl -s -w "%{http_code}" -o /tmp/mail_response.txt \
    -X POST ${API_URL} \
    -F "to=${TO_EMAIL}" \
    -F "subject=Master Data Export - ${CURRENT_DATE}" \
    -F "body=Hello,\n\nPlease find attached the ZIP file containing the master data export for ${CURRENT_DATE}." \
    -F "attachment=@${FILE_PATH}")

  HTTP_STATUS=$RESPONSE
  RESPONSE_BODY=$(cat /tmp/mail_response.txt)

  if [[ "$HTTP_STATUS" == "200" ]]; then
    log_info "Email sent successfully."
  else
    log_error "Failed to send email. Status: $HTTP_STATUS. Response: $RESPONSE_BODY"
    exit 1
  fi
}
