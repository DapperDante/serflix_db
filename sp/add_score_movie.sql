DELIMITER //
CREATE PROCEDURE `get_score_movies`(in in_profile_id int, in in_movie_id int)
begin
	SELECT s_movies.id, s_movies.score, s_movies.review, (
	 select json_arrayagg(json_object('score', s_movies.score,'review', s_movies.review, 'name', profiles.name))
	 FROM score_movies as s_movies
	 JOIN profiles ON profiles.id = s_movies.profile_id
	 AND s_movies.movie_id = in_movie_id
	) as results from score_movies as s_movies where s_movies.profile_id = in_profile_id and s_movies.movie_id = in_movie_id;
end //
DELIMITER ;