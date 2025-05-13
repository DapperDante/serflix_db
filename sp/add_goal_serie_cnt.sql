DROP PROCEDURE IF EXISTS add_goal_serie_cnt;

DELIMITER //
CREATE PROCEDURE `add_goal_serie_cnt`(IN in_profile_id INT, OUT out_goal_id INT)
BEGIN
	DECLARE serie_count INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET out_goal_id = NULL;
		ROLLBACK;
	END;

	START TRANSACTION;

	SELECT count(*) INTO serie_count
	FROM profile_series AS p_series 
	WHERE p_series.profile_id = in_profile_id 
	AND p_series.delete_at IS NULL;

	CASE
		WHEN serie_count >= 15 THEN
			SET out_goal_id = 8;
		WHEN serie_count >= 10 THEN
			SET out_goal_id = 7;
		WHEN serie_count >= 5 THEN
			SET out_goal_id = 6;
		WHEN serie_count >= 1 THEN
			SET out_goal_id = 5;
	END CASE;
	
	INSERT INTO profile_goals(profile_id, goal_id)
	VALUES(in_profile_id, out_goal_id);

	COMMIT;
END //
DELIMITER ; 
