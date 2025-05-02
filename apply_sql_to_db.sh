# !bin/bash 

if [ -f .env ]; then
  export $(cat .env | xargs)
else
  echo "File .env not found"
  exit 1
fi

echo "Starting apply SQL $FILE_SQL_TO_APPLY to database $DB_NAME"

mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD $DB_NAME < $FILE_SQL_TO_APPLY

if [ $? -eq 0 ]; then
    echo "Apply SQL to database $DB_NAME successfully"
else
    echo "Apply SQL to database $DB_NAME failed"
fi