DROP PROCEDURE IF EXISTS add_log_passwords;

DELIMITER //
CREATE PROCEDURE `add_log_passwords`(IN in_user_id INT, IN in_new_password VARCHAR(100))
BEGIN
	DECLARE old_password VARCHAR(100);
	SELECT password INTO old_password FROM users
	WHERE id = in_user_id;
	INSERT INTO log_passwords(user_id, old_password, new_password, timestamp)
	VALUES (in_user_id, old_password, in_new_password, utc_timestamp);
END //
DELIMITER ;