#!/bin/bash

# Set email parameters
EMAIL_TO="youremail@com" # Receiver
EMAIL_FROM="sender@com" # Sender
EMAIL_SUBJECT="TiDB Backup Failed"

# Create a temporary file for the backup log
BACKUP_LOG=$(mktemp)

# Run the backup command and capture its exit status
tiup br:v8.3.0  backup full -u "{PD-SERVER}" \
--storage "s3://{BUCKET_NAME}/tidb-prod-backup/backup-$(date +%Y%m%d-%H%M)?access-key={AWS_ACCESS_KEY}&secret-access-key={AWS_SECRET_ACCESS_KEY}>
2>&1 | tee "$BACKUP_LOG"

BACKUP_STATUS=${PIPESTATUS[0]}

# Check if backup failed
if [ $BACKUP_STATUS -ne 0 ]; then
    # Prepare email body with the backup log
    EMAIL_BODY="TiDB backup failed with exit code $BACKUP_STATUS on $(hostname) at $(date).\n\nBackup Log:\n$(cat "$BACKUP_LOG")"

    # Send email using mail command
    echo -e "$EMAIL_BODY" | ssmtp "$EMAIL_TO"
fi

# Clean up temporary file
rm -f "$BACKUP_LOG"
