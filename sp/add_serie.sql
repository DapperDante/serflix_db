DELIMITER //
CREATE PROCEDURE `add_serie`(in in_profile_id int, in in_serie_id int)
BEGIN 
	declare goal_id_got int;
	declare count_serie int;
	DECLARE tupla_id_serie_found int;
	-- First, It add or update the new serie
	select p_series.id into tupla_id_serie_found 
	from profile_series as p_series
	where p_series.profile_id = in_profile_id 
	and p_series.serie_id = in_serie_id;
	if tupla_id_serie_found then 
		update profile_series as p_serie
		set p_series.is_delete = 0
		where p_series.id = tupla_id_serie_found;
	else
		insert into profile_series(profile_id, serie_id)
		values (in_profile_id, in_serie_id);
		set tupla_id_serie_found = LAST_INSERT_ID();
	end if;
	-- after, verify if got a goal
	call add_goal_serie_count(in_profile_id, goal_id_got);
	if goal_id_got is not null then
		select tupla_id_serie_found as id, JSON_OBJECT('id', id, 'name', name, 'detail', detail, 'url', url) as goal
		FROM goals where id = goal_id_got;
	ELSE 
		SELECT tupla_id_serie_found AS id;
	end IF;
END //
DELIMITER ;