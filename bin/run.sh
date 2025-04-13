#!/bin/bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# source "$BASE_DIR/config/config.env"
source "$BASE_DIR/config/.env"
source "$BASE_DIR/lib/logging.sh"
source "$BASE_DIR/lib/db_export.sh"
source "$BASE_DIR/lib/notify.sh"

export PGPASSWORD="$DB_PASSWORD"

CURRENT_DATE=$(date "+%Y-%m-%d_%H-%M-%S")
ZIP_NAME="master_exports_${CURRENT_DATE}.zip"
ZIP_PATH="$BASE_DIR/${ZIP_NAME}"

log_info "Checking queries directory"
check_queries_folder "$BASE_DIR"

log_info "Exporting CSVs"
TMP_DIR="$BASE_DIR/csv_exports_${CURRENT_DATE}"
mkdir -p "$TMP_DIR"

# Now the export happens here
export_csvs "$BASE_DIR" "$CURRENT_DATE"

CSV_FILES=("$TMP_DIR"/*.csv)

# Check if there are any .csv files
if compgen -G "$TMP_DIR/*.csv" > /dev/null; then
  log_info "Zipping exports"
  zip -j "$ZIP_PATH" "$TMP_DIR"/*.csv
else
  log_error "No CSV files found in '$TMP_DIR'. Export may have failed."
  exit 1
fi

log_info "Sending email"
send_email "$CURRENT_DATE" "$ZIP_PATH"

log_info "Cleaning up"
rm -rf "$TMP_DIR" "$ZIP_PATH"

log_info "Done. The exported file is available at $ZIP_PATH"
