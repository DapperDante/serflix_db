DROP PROCEDURE IF EXISTS get_score_movie;

DELIMITER //
CREATE PROCEDURE `get_score_movie`(IN in_profile_id INT, IN in_movie_id INT, IN in_time_zone VARCHAR(70))
BEGIN
	DECLARE scores_json JSON;
	DECLARE its_score JSON;
	DECLARE avg_score INT;
	DECLARE result_json JSON;
	DECLARE message VARCHAR(255) DEFAULT 'Score movies retrieved';
	DECLARE error_code INT;

	SELECT AVG(s_movies.score) 
	INTO avg_score 
	FROM score_movies AS s_movies 
	WHERE s_movies.movie_id = in_movie_id;

	SELECT 
		JSON_OBJECT(
			'id', s_movies.id,
			'name', name,
			'score', score,
			'review', review,
			'created_at', DATE(CONVERT_TZ(created_at, '+00:00', in_time_zone))
		)
	INTO its_score
	FROM score_movies AS s_movies
	RIGHT JOIN profiles ON profiles.id = s_movies.profile_id
	WHERE s_movies.profile_id = in_profile_id
	AND s_movies.movie_id = in_movie_id;

	SELECT 
		JSON_ARRAYAGG(
			JSON_OBJECT(
					'score', s_movies.score, 
					'review', s_movies.review, 
					'name', profiles.name,
					'created_at', DATE(CONVERT_TZ(s_movies.created_at, '+00:00', in_time_zone))
			)
		)
	INTO scores_json
	FROM score_movies AS s_movies 
	JOIN profiles ON profiles.id = s_movies.profile_id
	AND s_movies.movie_id = in_movie_id
	AND s_movies.profile_id != in_profile_id; -- exclude the current profile's score of this movie

	SELECT JSON_OBJECT(
		'avg_score', avg_score,
		'scores', scores_json,
		'its_score', its_score
	) INTO result_json;

	SELECT JSON_OBJECT(
		'message', message, 
		'result', result_json,
		'error_code', error_code
	) AS response;
END //
DELIMITER ;