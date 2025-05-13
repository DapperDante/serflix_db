DROP PROCEDURE IF EXISTS get_serie;

DELIMITER //
CREATE PROCEDURE `get_serie`(IN in_profile_id INT, IN in_serie_id INT)
BEGIN
	DECLARE message VARCHAR(255) DEFAULT 'Serie found';
	DECLARE error_code INT;
	DECLARE result_json JSON;

	DECLARE CONTINUE HANDLER FOR NOT FOUND
	BEGIN 
		SET message = 'Serie not found';
		SET error_code = 1329;
		SET result_json = NULL;
		ROLLBACK;
	END;
	
	START TRANSACTION;

	CALL add_log_views(in_profile_id, in_serie_id, 'S');
	
	SELECT JSON_OBJECT(
		'id', id,
		'profile_id', profile_id,
		'serie_id', serie_id
	) INTO result_json
	FROM profile_series
	WHERE profile_id = in_profile_id
	AND serie_id = in_serie_id
	AND delete_at IS NULL;

	COMMIT;

	SELECT JSON_OBJECT(
		'message', message,
		'result', result_json,
		'error_code', error_code
	) AS response;
END //
DELIMITER ;