DROP PROCEDURE IF EXISTS add_movie;

delimiter //
CREATE PROCEDURE add_movie(IN in_profile_id INT, IN in_movie_id INT)
BEGIN 
	DECLARE goal_id_got INT;
	DECLARE id_movie_found INT;
	DECLARE message VARCHAR(255) DEFAULT 'Movie added successfully';
	DECLARE error_code INT;
	DECLARE result_json JSON;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET error_code = 45000;
		SET message = 'Error adding movie';
		ROLLBACK;
	END;

	-- First, verify if the profile's movie exists and evaluate if add or update
	SELECT p_movies.id INTO id_movie_found 
	FROM profile_movies AS p_movies 
	WHERE p_movies.profile_id = in_profile_id 
	AND p_movies.movie_id = in_movie_id;

	START TRANSACTION;
	
	IF id_movie_found IS NULL THEN 
		INSERT INTO profile_movies(profile_id, movie_id)
		VALUE (in_profile_id, in_movie_id);
		-- get the tupla's id of the movie if it's new profile's movie
		SELECT LAST_INSERT_ID() INTO id_movie_found;
	ELSE
		UPDATE profile_movies AS p_movies
		SET p_movies.delete_at = NULL
		WHERE p_movies.id = id_movie_found;
	END IF;
	
	-- after, verify if got a goal through number of movies added
	CALL add_goal_movie_cnt(in_profile_id, goal_id_got);

	SELECT JSON_OBJECT(
		'id', id_movie_found,
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
	) INTO result_json;

	COMMIT;

	SELECT JSON_OBJECT(
		'message', message,
		'result', result_json,
		'error_code', error_code
	) AS response;
END //
DELIMITER ;