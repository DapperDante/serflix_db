DROP PROCEDURE IF EXISTS add_profile_password;

DELIMITER //
CREATE PROCEDURE add_profile_password(IN in_profile_id INT, IN in_password VARCHAR(100))
BEGIN
  DECLARE result_json JSON;
  DECLARE error_code INT;
  DECLARE message VARCHAR(255);

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    SET error_code = 45000;
    SET message = 'Error adding password';
  END;

  START TRANSACTION;

  INSERT INTO profile_password(profile_id, password)
  VALUES (in_profile_id, in_password);
  
  COMMIT; 

  SELECT JSON_OBJECT(
    'message', message,
    'error_code', error_code,
    'result', result_json
  ) AS response;
END //
DELIMITER ;