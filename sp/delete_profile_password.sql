DROP PROCEDURE IF EXISTS delete_profile_password;

DELIMITER //
CREATE PROCEDURE delete_profile_password(IN in_profile_id INT)
BEGIN
  DECLARE result_json JSON;
  DECLARE message VARCHAR(255) DEFAULT "Password deleted successfully";
  DECLARE error_code INT;

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN 
    SET error_code = 45000;
    SET message = "Error deleting password";
  END;

  START TRANSACTION;

  DELETE FROM profile_password
  WHERE profile_id = in_profile_id;

  COMMIT;

  SELECT JSON_OBJECT(
    'result', result_json,
    'message', message,
    'error_code', error_code
  ) AS response;
END // 
DELIMITER ;