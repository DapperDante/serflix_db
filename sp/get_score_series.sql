DROP PROCEDURE IF EXISTS get_score_serie;

DELIMITER //
CREATE PROCEDURE `get_score_serie`(IN in_profile_id INT, IN in_serie_id INT)
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
			'id', id,
			'score', score,
			'review', review
	)
	INTO its_score
	FROM score_series AS s_series
	WHERE s_series.profile_id = in_profile_id
	AND s_series.serie_id = in_serie_id;

	SELECT 
		JSON_ARRAYAGG(
			JSON_OBJECT(
					'score', s_series.score, 
					'review', s_series.review, 
					'name', profiles.name
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