DROP PROCEDURE IF EXISTS get_score_serie;

DELIMITER //
CREATE PROCEDURE `get_score_serie`(IN in_profile_id INT, IN in_serie_id INT, IN in_time_zone VARCHAR(70))
BEGIN
	DECLARE result_json JSON;
	DECLARE avg_score INT;
	DECLARE score_json JSON;
	DECLARE its_score JSON;
	DECLARE message VARCHAR(255) DEFAULT 'Score series retrieved';
	DECLARE error_code INT;

	SELECT AVG(s_series.score) 
	INTO avg_score 
	FROM score_series AS s_series 
	WHERE s_series.serie_id = in_serie_id;
	
	SELECT 
		JSON_OBJECT(
			'id', s_series.id,
			'name', name,
			'score', score,
			'review', review,
			'created_at', DATE(CONVERT_TZ(created_at, '+00:00', in_time_zone))
	)
	INTO its_score
	FROM score_series AS s_series
	RIGHT JOIN profiles ON profiles.id = s_series.profile_id
	WHERE s_series.profile_id = in_profile_id
	AND s_series.serie_id = in_serie_id;

	SELECT 
		JSON_ARRAYAGG(
			JSON_OBJECT(
					'score', s_series.score, 
					'review', s_series.review, 
					'name', profiles.name,
					'created_at', DATE(CONVERT_TZ(s_series.created_at, '+00:00', in_time_zone))
			)
		)
	INTO score_json
	FROM score_series AS s_series
	JOIN profiles ON profiles.id = s_series.profile_id
	AND s_series.serie_id = in_serie_id
	AND s_series.profile_id != in_profile_id;

	SELECT JSON_OBJECT(
		'avg_score', avg_score,
		'scores', score_json,
		'its_score', its_score
	) INTO result_json;

	SELECT JSON_OBJECT(
		'message', message, 
		'result', result_json,
		'error_code', error_code
	) AS response;
END //
DELIMITER ;