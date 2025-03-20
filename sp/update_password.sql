DROP PROCEDURE IF EXISTS update_password;

DELIMITER //
CREATE PROCEDURE `update_password`(IN in_user_id INT, IN in_new_password VARCHAR(100))
BEGIN
	DECLARE timestamp_last_log datetime;
	DECLARE minimum_period datetime;
	DECLARE code_error INT;
	DECLARE message VARCHAR(255);
	DECLARE result_json JSON;
	
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET code_error = 45000;
		SET message = "You can't change your password until pass the period (1 month)";
		ROLLBACK;
	END;

	SET message = "password update";

	START TRANSACTION;

	SELECT timestamp INTO timestamp_last_log 
	FROM log_passwords  
	WHERE user_id = in_user_id 
	ORDER BY timestamp DESC LIMIT 1;

	SET minimum_period = date_sub(utc_timestamp(), interval 1 MONTH);

	CALL add_log_passwords(in_user_id, in_new_password);
	
	UPDATE users
	SET password = in_new_password
	WHERE id = in_user_id;
	
	IF timestamp_last_log >= minimum_period THEN
		SIGNAL SQLSTATE '45000';
	END IF;

	COMMIT;

	SELECT JSON_OBJECT(
		'result', result_json,
		'message', message,
		'code_error', code_error
	) AS response;
END //
DELIMITER ;