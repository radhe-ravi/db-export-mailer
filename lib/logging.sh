#!/bin/bash

LOG_FILE="logs/sql-exporter.log"
mkdir -p "$(dirname "$LOG_FILE")"

log_info() {
  echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $*" | tee -a "$LOG_FILE"
}

log_error() {
  echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $*" | tee -a "$LOG_FILE" >&2
}
