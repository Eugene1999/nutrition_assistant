#!/usr/bin/env bash
set -euo pipefail
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p ~/backups
PG=$(docker ps --format '{{.Names}}' | grep postgres)
[ -z "$PG" ] && { echo "postgres container not found"; exit 1; }
docker exec -t "$PG" pg_dump -U ${POSTGRES_USER:-n8n} ${POSTGRES_DB:-n8n} > ~/backups/n8n_${TIMESTAMP}.sql
find ~/backups -type f -name "n8n_*.sql" -mtime +14 -delete