#!/bin/bash

# Cek argumen input
if [ $# -ne 1 ]; then
  echo "Usage: $0 <log-directory>"
  exit 1
fi

LOG_DIR="$1"

# Cek apakah direktori ada
if [ ! -d "$LOG_DIR" ]; then
  echo "Error: Directory '$LOG_DIR' not found."
  exit 1
fi

# Buat folder untuk archive jika belum ada
ARCHIVE_DIR="./log_archives"
mkdir -p "$ARCHIVE_DIR"

# Timestamp untuk nama file
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_NAME}"

# Compress log files ke archive
tar --ignore-failed-read -czf "$ARCHIVE_PATH" -C "$LOG_DIR" .

if [ $? -eq 0 ]; then
  echo "Logs archived successfully to $ARCHIVE_PATH"
else
  echo "Error: Failed to archive logs."
  exit 1
fi

# Simpan log archive ke file log
LOGFILE="${ARCHIVE_DIR}/archive_log.txt"
echo "$(date +"%Y-%m-%d %H:%M:%S") - Archived logs from $LOG_DIR to $ARCHIVE_NAME" >> "$LOGFILE"
