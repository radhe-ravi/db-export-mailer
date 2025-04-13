#!/bin/bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$BASE_DIR/config/.env"
source "$BASE_DIR/lib/logging.sh"
source "$BASE_DIR/lib/main.sh"

export PGPASSWORD="$DB_PASSWORD"

main "$BASE_DIR"
