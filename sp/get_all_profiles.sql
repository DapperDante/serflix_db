DROP PROCEDURE IF EXISTS get_all_profiles;

DELIMITER //
CREATE PROCEDURE get_all_profiles(IN in_user_id INT)
BEGIN
  DECLARE result_json JSON;
  DECLARE message VARCHAR(255);
  DECLARE error_code INT;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    SET message = 'Error';
    SET error_code = 45000;
  END;

  SELECT JSON_ARRAYAGG(
    JSON_OBJECT(
      'id', profiles.id,
      'name', name,
      'img', img,
      'password', p_password.password
    )
  )
  INTO result_json
  FROM profiles
  LEFT JOIN profile_password AS p_password ON p_password.profile_id = profiles.id
  WHERE profiles.user_id = in_user_id;

  SELECT JSON_OBJECT(
    'result', result_json,
    'message', message,
    'error_code', error_code
  ) AS response;
END // 
DELIMITER ;