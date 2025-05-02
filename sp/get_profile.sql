DROP PROCEDURE IF EXISTS get_profile;

DELIMITER //
CREATE PROCEDURE get_profile(IN in_profile_id INT)
BEGIN
	DECLARE movies_json JSON;
	DECLARE series_json JSON;
	DECLARE goals_json JSON;
	DECLARE plan_json JSON;
	DECLARE is_password BOOLEAN;
	DECLARE error_code INT;
	DECLARE message VARCHAR(255) DEFAULT 'Profile found';
	-- this will be the final result
	DECLARE result_json JSON;
	
	SELECT 
		JSON_ARRAYAGG(
			JSON_OBJECT(
				'id',movies.movie_id
			)
		)
	INTO movies_json 
	FROM profile_movies AS movies 
	WHERE movies.profile_id = in_profile_id
	AND movies.delete_at IS NULL;

	SELECT 
		JSON_ARRAYAGG(
			JSON_OBJECT(
				'id',series.serie_id
			)
		) 
	INTO series_json 
	FROM profile_series AS series 
	WHERE series.profile_id = in_profile_id
	AND series.delete_at IS NULL;

	SELECT 
		JSON_ARRAYAGG(
			JSON_OBJECT(
				'id', goals.id, 
				'name', goals.name, 
				'detail', goals.detail, 
				'url', goals.url
			)
		)
	INTO goals_json 
	FROM profile_goals
	JOIN goals ON goals.id = goal_id AND profile_goals.profile_id = in_profile_id;
	
	-- if there is not a plan, it will return the default plan
	SELECT 
		JSON_OBJECT(
			'id', plans.id, 
			'name', plans.name
		)
	INTO plan_json 
	FROM plans WHERE id = (
		SELECT IFNULL(
			(
				SELECT plan_id FROM suscriptions 
				WHERE user_id = (
					SELECT user_id FROM profiles
					WHERE id = in_profile_id
				)
			),
			1 -- default plan (free)
		)
	);

	SELECT 
		IFNULL(
			(
				SELECT TRUE FROM profile_password
				WHERE profile_id = in_profile_id
			),
			FALSE
		) INTO is_password;
	
	SELECT 
		JSON_OBJECT(
			'id', id,
			'name', name,
			'img', img,
			'movies', movies_json,
			'series', series_json,
			'goals', goals_json,
			'plan', plan_json,
			'password', is_password
		)
	INTO result_json
	FROM profiles
	WHERE id = in_profile_id;

	SELECT JSON_OBJECT(
		'result', result_json,
		'error_code', error_code,
		'message', message
	) AS response;
END //
DELIMITER ;