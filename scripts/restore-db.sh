#!/usr/bin/env bash
set -euo pipefail
FILE="$1"
[ -f "$FILE" ] || { echo "No file"; exit 1; }
PG=$(docker ps --format '{{.Names}}' | grep postgres)
cat "$FILE" | docker exec -i "$PG" psql -U ${POSTGRES_USER:-n8n} -d ${POSTGRES_DB:-n8n}