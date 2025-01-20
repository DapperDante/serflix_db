DELIMITER //
CREATE PROCEDURE `get_score_movies`(in in_profile_id int, in in_movie_id int)
begin
	declare flag int;
	declare results JSON;
	declare avg_score int;
	select AVG(s_movies.score) into avg_score from score_movies as s_movies where s_movies.movie_id = in_movie_id;
	-- first get all scores for show in final
	select json_arrayagg(json_object('score', s_movies.score, 'review', s_movies.review, 'name', profiles.name))
	into results
	from score_movies as s_movies 
	join profiles on profiles.id = s_movies.profile_id
	and s_movies.movie_id = in_movie_id;
	-- verify if this profile has a review of this movie
	select exists(
		select s_movies.id from score_movies as s_movies 
		where s_movies.profile_id = in_profile_id and s_movies.movie_id = in_movie_id
	) into flag;
	if flag then
		SELECT s_movies.id, s_movies.score, s_movies.review, avg_score, results as results
		from score_movies as s_movies where s_movies.profile_id = in_profile_id and s_movies.movie_id = in_movie_id;
	else
		select null as id, null as score, null as review, avg_score, results;
	end if;
end //
DELIMITER ;