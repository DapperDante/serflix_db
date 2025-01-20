DELIMITER //
CREATE PROCEDURE `get_profile`(in in_profile_id int)
BEGIN
	SELECT profiles.name AS name, profiles.img AS img, (
			SELECT group_concat(movies.movie_id) AS movies FROM profile_movies AS movies WHERE movies.is_delete = 0 AND movies.profile_id = in_profile_id
		) AS movies, (
			SELECT group_concat(series.serie_id) AS series FROM profile_series AS series WHERE series.is_delete = 0 AND series.profile_id = in_profile_id
		) AS series, (
			 select json_arrayagg(json_object('id', goals.id, 'name', goals.name, 'detail', goals.detail, 'url', goals.url)) from profile_goals
			 join goals on goals.id = goal_id and profile_goals.profile_id = in_profile_id
		) as goals FROM profiles WHERE profiles.id = in_profile_id;
END //
DELIMITER ;