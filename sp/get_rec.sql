DROP PROCEDURE IF EXISTS get_rec;

DELIMITER //
CREATE PROCEDURE `get_rec`()
BEGIN
	DECLARE result_json JSON;
	DECLARE error_code INT;
	DECLARE message VARCHAR(255) DEFAULT 'Top 5 views';
	DECLARE number_of_views INT DEFAULT 5;

	SELECT 
		JSON_ARRAYAGG(
			JSON_OBJECT(
				'item_id', item_id, 
				'type', type
			)
		)
	INTO result_json
	FROM (
		SELECT item_id, type 
		FROM log_views
		group by item_id, type
		order by COUNT(*) desc
		limit number_of_views	
	) AS top_views;
	
	SELECT JSON_OBJECT(
		'result', result_json,
		'error_code', error_code,
		'message', message
	) AS response;
END //
DELIMITER ;