# !bin/bash

if [ -f .env ]; then
  export $(cat .env | xargs)
else
  echo "File .env not found"
  exit 1
fi

DIR_BACKUP="./db_backup"
DATE_BACKUP=$(date +%Y%m%d)
FILE_NAME_OUTPUT="${DB_NAME}_${DATE_BACKUP}.backup.sql"

echo "Starting backup database $DB_NAME"

mysqldump -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD $DB_NAME > $DIR_BACKUP/$FILE_NAME_OUTPUT

if [ $? -eq 0 ]; then
    echo "Backup database $DB_NAME successfully"
else
    echo "Backup database $DB_NAME failed"
fi