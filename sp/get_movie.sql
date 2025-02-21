DROP PROCEDURE IF EXISTS get_movie;

delimiter //
create procedure `get_movie`(in in_profile_id int, in in_movie_id int)
begin
	call add_log_views(in_profile_id, in_movie_id, 'M');
	select movie_id from profile_movies
	where profile_id = in_profile_id 
	and movie_id = in_movie_id
	and delete_at is null;
end //
delimiter ;