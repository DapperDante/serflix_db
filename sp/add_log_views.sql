DROP PROCEDURE IF EXISTS add_log_views;

DELIMITER //
CREATE PROCEDURE `add_log_views`(IN in_profile_id INT, IN in_item_id INT, IN in_type CHAR)
BEGIN
	INSERT INTO log_views(profile_id, item_id, type, timestamp)
	VALUES (in_profile_id, in_item_id, in_type, utc_timestamp);
END //
DELIMITER ;