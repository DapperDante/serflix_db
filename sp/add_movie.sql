DROP PROCEDURE IF EXISTS add_movie;

delimiter //
create procedure `add_movie`(in in_profile_id int, in in_movie_id int)
BEGIN 
	declare goal_id_got int;
	declare count_movie int;
	declare tupla_id_movie_found int;

	-- First, It add or update the new movie
	select p_movies.id into tupla_id_movie_found 
	from profile_movies  as p_movies 
	where p_movies.profile_id = in_profile_id 
	and p_movies.movie_id = in_movie_id;

	if tupla_id_movie_found then 
		update profile_movies as p_movies
		set p_movies.delete_at = null
		where p_movies.id = tupla_id_movie_found;
	else
		insert into profile_movies(profile_id, movie_id)
		values (in_profile_id, in_movie_id);
		set tupla_id_movie_found = LAST_INSERT_ID();
	end if;
	
	-- after, verify if got a goal
	call add_goal_movie_cnt(in_profile_id, goal_id_got);
	
	if goal_id_got is not null then
		select tupla_id_movie_found as id, JSON_OBJECT('id', id, 'name', name, 'detail', detail, 'url', url) as goal
		FROM goals where id = goal_id_got;
	ELSE 
		SELECT tupla_id_movie_found AS id, null goal;
	end IF;
END //
delimiter ;