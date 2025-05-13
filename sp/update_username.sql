DROP PROCEDURE IF EXISTS update_username;

DELIMITER //
CREATE PROCEDURE update_username(IN in_user_id INT, IN in_new_username VARCHAR(65))
BEGIN
  DECLARE result_json JSON;
  DECLARE message VARCHAR(255) DEFAULT 'Username updated';
  DECLARE error_code INT;
  
  DECLARE CONTINUE HANDLER FOR 1062
  BEGIN
    SET message = 'The username is used';
    SET error_code = 1062;
  END;

  START TRANSACTION;

  UPDATE users
  SET username = in_new_username
  WHERE id = in_user_id;
  
  COMMIT;
  
  SELECT JSON_OBJECT(
    'result', result_json,
    'message', message,
    'error_code', error_code
  ) AS response;
END //
DELIMITER ;