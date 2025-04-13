#!/bin/bash

# source "$BASE_DIR/lib/db_export.sh"
# source "$BASE_DIR/lib/utils.sh"
# source "$BASE_DIR/lib/notify.sh"
source "$BASE_DIR/lib/init.sh"

main() {
  local BASE_DIR="$1"
  local CURRENT_DATE
  CURRENT_DATE=$(date "+%Y-%m-%d_%H-%M-%S")
  local TMP_DIR="$BASE_DIR/csv_exports_${CURRENT_DATE}"
  local ZIP_NAME="master_exports_${CURRENT_DATE}.zip"
  local ZIP_PATH="$BASE_DIR/$ZIP_NAME"

  log_info "Checking queries directory"
  check_queries_folder "$BASE_DIR"

  log_info "Exporting CSVs"
  export_csvs "$BASE_DIR" "$CURRENT_DATE"

  log_info "Zipping exports"
  create_zip_from_csvs "$TMP_DIR" "$ZIP_PATH"

  log_info "Sending email"
  send_email "$CURRENT_DATE" "$ZIP_PATH"

  log_info "Cleaning up"
  cleanup_temp_files "$TMP_DIR" "$ZIP_PATH"

  log_info "Done. Temp files removed."
}