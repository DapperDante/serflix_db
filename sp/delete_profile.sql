DROP PROCEDURE IF EXISTS delete_profile;

DELIMITER //
CREATE PROCEDURE delete_profile(IN in_profile_id INT)
BEGIN
  DECLARE result_json JSON;
  DECLARE error_code INT;
  DECLARE message VARCHAR(255) DEFAULT 'profile deleted successfully';
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    SET error_code = 45000;
    SET message = "Error";
  END;

  START TRANSACTION;

  UPDATE log_views
  SET profile_id = NULL
  WHERE profile_id = in_profile_id;

  DELETE FROM profiles
  WHERE id = in_profile_id;

  COMMIT;
  
  SELECT JSON_OBJECT(
    'result', result_json,
    'error', error_code,
    'message', message
  ) AS response;
END //
DELIMITER ; 