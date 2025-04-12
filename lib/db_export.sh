#!/bin/bash


check_queries_folder() {
  local BASE_DIR="$1"
  local QUERY_DIR="${BASE_DIR}/queries"

  if [[ ! -d "$QUERY_DIR" ]]; then
    log_error "The 'queries/' folder does not exist at $QUERY_DIR."
    exit 1
  fi

  if ! find "$QUERY_DIR" -type f -name "*.sql" | grep -q .; then
    log_error "No .sql files found in '$QUERY_DIR'."
    exit 1
  fi

  log_info "Found SQL files in '$QUERY_DIR'."
}


export_csvs() {
  local BASE_DIR="$1"
  local CURRENT_DATE="$2"
  local QUERY_DIR="${BASE_DIR}/queries"
  local TMP_DIR="${BASE_DIR}/csv_exports_${CURRENT_DATE}"

  mkdir -p "$TMP_DIR"

  for file in "$QUERY_DIR"/*.sql; do
    if [[ -f "$file" ]]; then
      local BASENAME
      BASENAME=$(basename "$file" .sql)
      local OUTPUT_FILE="${TMP_DIR}/${BASENAME}_${CURRENT_DATE}.csv"
      log_info "Running query: $BASENAME"
      psql -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -U "$DB_USER" -c "\COPY ($(cat "$file")) TO '$OUTPUT_FILE' CSV HEADER"
    fi
  done

  echo "$TMP_DIR"
}

