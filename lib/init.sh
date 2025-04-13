#!/bin/bash

# Load environment variables
source "$BASE_DIR/config/.env"

# Logging utilities
source "$BASE_DIR/lib/logging.sh"

# Utility functions
source "$BASE_DIR/lib/utils.sh"

# DB export logic
source "$BASE_DIR/lib/db_export.sh"

# Notification/email logic
source "$BASE_DIR/lib/notify.sh"
