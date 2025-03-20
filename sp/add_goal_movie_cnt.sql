DROP PROCEDURE IF EXISTS add_goal_movie_cnt;

DELIMITER //
CREATE PROCEDURE `add_goal_movie_cnt`(IN in_profile_id INT, OUT out_goal_id INT)
BEGIN
	DECLARE movie_count INT;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET out_goal_id = NULL;
		ROLLBACK;
	END;

	START TRANSACTION;

	SELECT count(*) INTO movie_count
	FROM profile_movies AS p_movies 
	WHERE p_movies.profile_id = in_profile_id 
	AND p_movies.delete_at IS NULL;

	CASE
		WHEN movie_count >= 50 THEN
			SET out_goal_id= 9;
		WHEN movie_count >= 20 THEN
			SET out_goal_id = 3;
		WHEN movie_count >= 10 THEN
			SET out_goal_id = 2;
		WHEN movie_count >= 5 THEN
			SET out_goal_id = 1;
		WHEN movie_count >= 1 THEN
			SET out_goal_id = 4;
	END CASE;

	-- TODO check if the goal already exists before insert a new goal

	INSERT INTO profile_goals(profile_id, goal_id)
	VALUES(in_profile_id, out_goal_id);
	
	COMMIT;
END //
DELIMITER ;