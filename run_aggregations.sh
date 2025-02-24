#!/bin/bash

# ===================================================================
# Script Name: run_aggregations.sh
# Description: Executes multiple aggregation queries from SQL files 
#              to populate aggregate tables.
# Author: [Hazem Hassan]
# Date Created: [2024-11-04]
# Date Updated: [2024-11-25]
# Version: 1.0
# ===================================================================

# --------- Load Configuration ---------
CONFIG_FILE="config.env"

if [[ ! -f $CONFIG_FILE ]]; then
    echo "ERROR: Configuration file '$CONFIG_FILE' not found."
    exit 1
fi

if [[ ! -r $CONFIG_FILE ]]; then
    echo "ERROR: Configuration file '$CONFIG_FILE' is not readable."
    exit 1
fi

# Load configuration variables
source "$CONFIG_FILE"

# Check if required variables are set
# Check if required variables are set, if not, exit with an error message
: "${CLICKHOUSE_HOST:?CLICKHOUSE_HOST is not set in $CONFIG_FILE}"
: "${CLICKHOUSE_PORT:?CLICKHOUSE_PORT is not set in $CONFIG_FILE}"
: "${DATABASE_NAME:?DATABASE_NAME is not set in $CONFIG_FILE}"
: "${LOG_FILE:?LOG_FILE is not set in $CONFIG_FILE}"

QUERY_DIR="./queries"

# --------- Utility Functions ---------
log_message() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "$LOG_FILE"
}

execute_query() {
    local query_file="$1"

    log_message "Executing query from file: $query_file"
    clickhouse-client \
        --host="$CLICKHOUSE_HOST" \
        --port="$CLICKHOUSE_PORT" \
        --database="$DATABASE_NAME" \
        --query="$(cat "$query_file")"

    if [[ $? -ne 0 ]]; then
        log_message "ERROR: Failed to execute query from file: $query_file"
        return 1
    fi

    log_message "Successfully executed query from file: $query_file"
    return 0
}

# --------- Main Execution ---------
log_message "Starting data aggregation process."

if [[ ! -d $QUERY_DIR ]]; then
    log_message "ERROR: Query directory '$QUERY_DIR' not found."
    exit 1
fi
# Check if there are any SQL files in the directory
shopt -s nullglob
query_files=("$QUERY_DIR"/*.sql)
shopt -u nullglob

if [[ ${#query_files[@]} -eq 0 ]]; then
    log_message "No SQL files found in '$QUERY_DIR'."
    exit 1
fi

# Iterate over query files
for query_file in "${query_files[@]}"; do
    execute_query "$query_file"
    if [[ $? -ne 0 ]]; then
        log_message "Skipping remaining queries due to error."
        exit 1
    fi
done
    done
else
    log_message "No SQL files found in '$QUERY_DIR'."
    exit 1
fi
done

log_message "Data aggregation process completed successfully."
exit 0
