#!/bin/bash

# Remote VM details
REMOTE_USER="penta"
REMOTE_HOST="172.16.2.76"
REMOTE_PASSWORD="P3nta@2023"
REMOTE_FOLDER="/home/penta/database_backups"

# PostgreSQL server details
PG_HOST="172.16.2.67"
PG_PORT="5432"
PG_USER="postgres"
#PG_PASSWORD="KPPQQkNtVQ5MeLU"

# Backup location and retention
BACKUP_DIR="/tmp/pg_backups"
BACKUP_RETENTION_DAYS=1

# Create timestamp for folder name
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create a directory for current backup
mkdir -p "$BACKUP_DIR/$TIMESTAMP"

# Connect to PostgreSQL and take individual backups for each database
databases=$(psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -l -t | cut -d'|' -f1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

for db in $databases; do
    if [ "$db" != "template0" ] && [ "$db" != "template1" ]; then
        pg_dump -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$db" > "$BACKUP_DIR/$TIMESTAMP/$db.sql"
    fi
done

# Transfer backups to remote server using password authentication
sshpass -p "$REMOTE_PASSWORD" scp -r "$BACKUP_DIR/$TIMESTAMP" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_FOLDER"

# Delete backups older than retention period
find "$BACKUP_DIR" -mindepth 1 -type d -mtime +"$BACKUP_RETENTION_DAYS" -exec rm -rf {} \;
