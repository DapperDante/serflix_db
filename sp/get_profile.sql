DROP PROCEDURE IF EXISTS get_profile;

delimiter //
create procedure `get_profile`(in in_profile_id int)
BEGIN
	SELECT profiles.name AS name, profiles.img AS img, (
			SELECT json_arrayagg(json_object('id',movies.movie_id)) AS movies 
			FROM profile_movies AS movies 
			WHERE movies.profile_id = in_profile_id
			and movies.delete_at is null 
		) AS movies, (
			SELECT json_arrayagg(json_object('id',series.serie_id)) AS series 
			FROM profile_series AS series 
			WHERE series.profile_id = in_profile_id
			and series.delete_at is null
		) AS series, (
			 select json_arrayagg(json_object('id', goals.id, 'name', goals.name, 'detail', goals.detail, 'url', goals.url)) 
			 from profile_goals
			 join goals on goals.id = goal_id and profile_goals.profile_id = in_profile_id
		) as goals FROM profiles WHERE profiles.id = in_profile_id;
END //
delimiter ;