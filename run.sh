#!/bin/bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
export BASE_DIR

source "$BASE_DIR/lib/init.sh"
source "$BASE_DIR/lib/main.sh"

export PGPASSWORD="$DB_PASSWORD"

main "$BASE_DIR"
