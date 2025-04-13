#!/bin/bash

create_zip_from_csvs() {
  local TMP_DIR="$1"
  local ZIP_PATH="$2"

  if compgen -G "$TMP_DIR/*.csv" > /dev/null; then
    zip -j "$ZIP_PATH" "$TMP_DIR"/*.csv
  else
    log_error "No CSV files found in '$TMP_DIR'. Export may have failed."
    exit 1
  fi
}

cleanup_temp_files() {
  local TMP_DIR="$1"
  local ZIP_PATH="$2"
  rm -rf "$TMP_DIR"
  rm -f "$ZIP_PATH"
}