#!/bin/sh

# Define directory and filename
DIR=/apps
TAR_FILE=/${PREFIX:-"app"}-$(date +%Y%m%d%H%M).tar.gz

# Create tar file
tar -cvzf ${TAR_FILE}  ${DIR}

# Sync upload to cloud storage
bypy -v upload ${TAR_FILE} backup/

# Cleanup local tar file
rm ${TAR_FILE}

# Read the cron schedule from the environment variable
CRON_SCHEDULE=${CRON_SCHEDULE:-"0 0 * * *"}

# Function to check if the cron job already exists
check_cron_job_exists() {
  CRON_LIST=$(crontab -l)
  if echo "$CRON_LIST" | grep -qF "$1"; then
    return 0
  else
    return 1
  fi
}

# Add Cron job
if ! check_cron_job_exists "bypy"; then
    (
    crontab -l
    echo "${CRON_SCHEDULE} /bin/sh -c 'export DIR=/apps && export TAR_FILE=/\${PREFIX:-"app"}-\$(date +%Y%m%d%H%M).tar.gz && tar -czvf \${TAR_FILE}  \${DIR} . && bypy -v upload \${TAR_FILE} backup/ && rm \${TAR_FILE}' >> /proc/1/fd/1 2>&1"
    ) | crontab -
fi

crond -f -d 6 -c /etc/crontabs