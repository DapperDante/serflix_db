DELIMITER //
CREATE PROCEDURE `add_goal_movie_count`(in in_profile_id int, out out_goal_id int)
BEGIN 
	declare movie_count int;
	declare flag int;
	select count(*) into movie_count 
	from profile_movies as p_movies 
	where p_movies.profile_id = in_profile_id 
	and p_movies.is_delete = 0;
	case
		when movie_count >= 50 then
			set out_goal_id= 9;
		when movie_count >= 20 then
			set out_goal_id = 3;
		when movie_count >= 10 then
			set out_goal_id = 2;
		when movie_count >= 5 then
			set out_goal_id = 1;
		when movie_count >= 1 then
			set out_goal_id = 4;
	end case;
	select exists (
		select p_goal.id from profile_goals as p_goal 
		where p_goal.profile_id = in_profile_id 
		and p_goal.goal_id = out_goal_id
	) into flag;
	if flag then
		set out_goal_id = null;
	else
		insert into profile_goals(profile_id, goal_id)
		values(in_profile_id, out_goal_id);
	end if;
END //
DELIMITER ;