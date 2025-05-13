DROP PROCEDURE IF EXISTS update_profile_password;

DELIMITER //
CREATE PROCEDURE update_profile_password(IN in_profile_id INT, IN in_password VARCHAR(100))
BEGIN
  DECLARE result_json JSON;
  DECLARE error_code INT;
  DECLARE message VARCHAR(255) DEFAULT "Password updated";

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN 
    SET error_code = 45000;
    SET message = "Error updating password";
    ROLLBACK;
  END; 

  START TRANSACTION;
  
  UPDATE profile_password
  SET password = in_password
  WHERE profile_id = in_profile_id;

  COMMIT;
  
  SELECT JSON_OBJECT(
    'message', message,
    'result', result_json,
    'error_code', error_code
  ) AS response;
END //
DELIMITER ;