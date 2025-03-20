DROP PROCEDURE IF EXISTS add_serie;

DELIMITER //
CREATE PROCEDURE `add_serie`(in in_profile_id int, in in_serie_id int)
BEGIN 
	DECLARE goal_id_got INT;
	DECLARE count_serie INT;
	DECLARE id_serie_found INT;
	DECLARE message VARCHAR(255); 
	DECLARE error_code INT;
	DECLARE result_json JSON;

	-- First, It add or update the new serie
	SELECT p_series.id INTO id_serie_found 
	FROM profile_series AS p_series
	WHERE p_series.profile_id = in_profile_id 
	AND p_series.serie_id = in_serie_id;
	
	IF tupla_id_serie_found THEN
		UPDATE profile_series AS p_series
		SET p_series.delete_at = NULL
		WHERE p_series.id = id_serie_found;
	ELSE
		INSERT INTO profile_series(profile_id, serie_id)
		VALUES (in_profile_id, in_serie_id);
		SET id_serie_found = LAST_INSERT_ID();
	END IF;
	
	-- after, verify if got a goal
	CALL add_goal_serie_cnt(in_profile_id, goal_id_got);
	
	SET message = 'Serie added';
	SET result_json = JSON_OBJECT(
		'id', id_serie_found,
		'goal', (
			SELECT JSON_OBJECT(
				'id', id, 
				'name', name, 
				'detail', detail, 
				'url', url
			) 
			FROM goals 
			WHERE id = goal_id_got
		)
	);

	SELECT JSON_OBJECT(
		'message', message,
		'result', result_json,
		'error_code', error_code
	) AS response;
END //
DELIMITER ;