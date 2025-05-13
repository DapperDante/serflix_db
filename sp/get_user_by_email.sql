DROP PROCEDURE IF EXISTS get_user_by_email;

DELIMITER //
CREATE PROCEDURE get_user_by_email(IN in_email VARCHAR(255))
BEGIN 
  DECLARE result_json JSON;
  DECLARE message VARCHAR(255) DEFAULT 'User found';
  DECLARE error_code INT;
  DECLARE auth_status_find BOOLEAN;

  DECLARE CONTINUE HANDLER FOR NOT FOUND
  BEGIN
    SET message = 'User not found';
    SET error_code = 1329;
  END;

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    SET message = 'User not authenticated yet';
    SET error_code = 45000;
  END;

  SELECT 
    JSON_OBJECT(
      'id', id,
      'username', username,
      'email', email,
      'password', password,
      'is_first_time', is_first_time
    ),
    auth_status
  INTO result_json, auth_status_find
  FROM users
  WHERE email = in_email;

  IF (auth_status_find IS NULL OR auth_status_find = 0) AND error_code IS NULL THEN
    SIGNAL SQLSTATE '45000';
  END IF;
  
  SELECT JSON_OBJECT(
    'result', result_json,
    'message', message,
    'error_code', error_code
  ) AS response;
END //
DELIMITER ;
