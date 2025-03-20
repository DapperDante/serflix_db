DROP PROCEDURE IF EXISTS authenticate_user;

DELIMITER //
CREATE PROCEDURE authenticate_user(IN in_user_id INT)
BEGIN 
  UPDATE users SET auth_status = UTC_TIMESTAMP()
  WHERE id = in_user_id;
END //
DELIMITER ;