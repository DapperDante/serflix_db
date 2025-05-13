DROP PROCEDURE IF EXISTS get_posters;

DELIMITER //
CREATE PROCEDURE get_posters()
BEGIN
  DECLARE result_json JSON;
  DECLARE error_code INT;
  DECLARE message VARCHAR(255) DEFAULT 'Posters found';

  SELECT JSON_ARRAYAGG(url)
  INTO result_json
  FROM (
    SELECT url
    FROM posters 
    LIMIT 25
  ) AS posters;

  SELECT JSON_OBJECT(
    'message', message,
    'result', result_json,
    'error_code', error_code
  ) AS response;
END //
DELIMITER ;