DROP PROCEDURE IF EXISTS get_score_movies;

DELIMITER //
CREATE PROCEDURE `get_score_movies`(IN in_profile_id INT, IN in_movie_id INT)
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
			'id', id,
			'score', score,
			'review', review
		)
	INTO its_score
	FROM score_movies AS s_movies
	WHERE s_movies.profile_id = in_profile_id
	AND s_movies.movie_id = in_movie_id;

	SELECT 
		JSON_ARRAYAGG(
			JSON_OBJECT(
					'score', s_movies.score, 
					'review', s_movies.review, 
					'name', profiles.name
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