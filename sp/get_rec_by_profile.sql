DROP PROCEDURE IF EXISTS get_rec_by_profile;

DELIMITER //
CREATE PROCEDURE `get_rec_by_profile`(IN in_profile_id INT)
BEGIN
	DECLARE result_json JSON;
	DECLARE error_code INT;
	DECLARE message VARCHAR(255);
	DECLARE last_viewed_json JSON;
	DECLARE recommendations_json JSON;
	DECLARE number_of_views INT DEFAULT 5;
	SELECT 
		JSON_OBJECT(
				'item_id', item_id, 
				'type', type
		)
	INTO last_viewed_json 
	FROM log_views
	WHERE profile_id = in_profile_id 
	ORDER BY timestamp DESC LIMIT 1;

	SELECT 
		JSON_ARRAYAGG(
			JSON_OBJECT(
				'item_id', item_id, 
				'type', type
			)
		)
	INTO recommendations_json
	FROM (
		SELECT item_id, type	
		FROM log_views 
		WHERE profile_id = in_profile_id
		AND item_id != JSON_UNQUOTE(JSON_EXTRACT(last_viewed_json, '$.item_id')) -- to discard the last viewed item because it's into last_viewed_json
		GROUP BY item_id, type
		ORDER BY COUNT(*) DESC
		LIMIT number_of_views
	) AS recommendations;
	
	SELECT 
		JSON_OBJECT(
			'last_viewed', last_viewed_json,
			'recommendations', recommendations_json
	) INTO result_json;

	SELECT 
		JSON_OBJECT(
			'result', result_json,
			'error_code', error_code,
			'message', message
	) AS response; 
END //
DELIMITER ;