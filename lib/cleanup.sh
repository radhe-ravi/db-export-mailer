#!/bin/bash

cleanup_temp_files() {
  local TMP_DIR="$1"
  local ZIP_PATH="$2"
  rm -rf "$TMP_DIR"
  rm -f "$ZIP_PATH"
}
