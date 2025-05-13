-- march 21, 2025 

UPDATE score_movies
SET created_at = UTC_TIMESTAMP()
WHERE created_at IS NULL;

-- march 27, 2025

ALTER TABLE users
CHANGE COLUMN auth_status aux TIMESTAMP;

ALTER TABLE auth_status
ADD COLUMN auth_status BOOLEAN;

UPDATE users
SET auth_status = 0
WHERE aux IS NOT NULL;

ALTER TABLE users
DROP COLUMN aux;