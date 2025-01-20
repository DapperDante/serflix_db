DELIMITER //
CREATE PROCEDURE `add_goal_serie_count`(in in_profile_id int, out out_goal_id int)
BEGIN 
	declare serie_count int;
	declare flag int;
	select count(*) into serie_count 
	from profile_series as p_series 
	where p_series.profile_id = in_profile_id 
	and p_series.is_delete = 0;
	case
		when serie_count >= 15 then
			set out_goal_id = 8;
		when serie_count >= 10 then
			set out_goal_id = 7;
		when serie_count >= 5 then
			set out_goal_id = 6;
		when serie_count >= 1 then
			set out_goal_id = 5;
	end case;
	select exists (
		select p_goal.id from profile_goals as p_goal 
		where p_goal.profile_id = in_profile_id 
		and p_goal.goal_id = out_goal_id
	) into flag;
	if flag then
		SET out_goal_id = null;
	else
		insert into profile_goals(profile_id, goal_id)
		values(in_profile_id, out_goal_id);
	end if;
END //
DELIMITER ;