# !bin/bash

if [ -f .env ]; then
  export $(cat .env | xargs)
else
  echo "File .env not found"
  exit 1
fi

DIR_BACKUP="./db_backup"

echo "Starting apply backup database $DB_NAME"

mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD $DB_NAME < $DIR_BACKUP/$FILE_TO_APPLY_BACKUP

if [ $? -eq 0 ]; then
    echo "Apply backup database $DB_NAME successfully"
else
    echo "Apply backup database $DB_NAME failed"
fi