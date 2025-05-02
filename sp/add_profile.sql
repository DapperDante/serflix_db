DROP PROCEDURE IF EXISTS add_profile;

DELIMITER //
CREATE PROCEDURE add_profile(in in_user_id INT, in in_name VARCHAR(65), in in_img VARCHAR(100))
BEGIN 
  DECLARE count_profiles TINYINT;
  DECLARE id_plan_user TINYINT;
  DECLARE result_json JSON;
  DECLARE error_code INT;
  DECLARE message VARCHAR(255) DEFAULT 'Profile added successfully';

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    SET error_code = 45000;
    SET message = 'User exceeds the limit of profiles';
    SET result_json = NULL;
    ROLLBACK;
  END;

  START TRANSACTION;

  SELECT COUNT(*) INTO count_profiles 
  FROM profiles
  WHERE user_id = in_user_id;

  INSERT INTO profiles (user_id, name, img)
  VALUES (in_user_id, in_name, in_img);

  SELECT JSON_OBJECT(
    'id', LAST_INSERT_ID()
  ) INTO result_json;

  SELECT plan_id INTO id_plan_user
  FROM suscriptions WHERE user_id = in_user_id;

  IF ((id_plan_user = 1 OR id_plan_user IS NULL) AND count_profiles >= 5) OR count_profiles >= 10 THEN 
    SIGNAL SQLSTATE '45000';
  END IF;

  COMMIT;

  SELECT JSON_OBJECT(
    'message', message, 
    'result', result_json,
    'error_code', error_code
  ) AS response;
END //
DELIMITER ;