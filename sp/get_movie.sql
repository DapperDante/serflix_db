DROP PROCEDURE IF EXISTS get_movie;

DELIMITER //
CREATE PROCEDURE `get_movie`(IN in_profile_id INT, IN in_movie_id INT)
BEGIN
	DECLARE message VARCHAR(255) DEFAULT 'Movie found';
	DECLARE error_code INT;
	DECLARE result_json JSON;

	DECLARE CONTINUE HANDLER FOR NOT FOUND
	BEGIN
		SET message = 'Movie not found';
		SET error_code = 1329;
		SET result_json = NULL;
		ROLLBACK;
	END;
	
	START TRANSACTION;

	SELECT JSON_OBJECT(
		'id', id,
		'profile_id', profile_id,
		'movie_id', movie_id
	) INTO result_json 
	FROM profile_movies
	WHERE profile_id = in_profile_id 
	AND movie_id = in_movie_id
	AND delete_at IS NULL;
	
	COMMIT;

	CALL add_log_views(in_profile_id, in_movie_id, 'M');
	
	SELECT JSON_OBJECT(
		'message', message,
		'result', result_json,
		'error_code', error_code
	) AS response;
END //
DELIMITER ;