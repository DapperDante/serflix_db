DELIMITER //
CREATE PROCEDURE `get_score_series`(in in_profile_id int, in in_serie_id int)
begin
	declare flag int;
	declare results JSON;
	declare avg_score int;
	select AVG(s_series.score) into avg_score from score_series as s_series where s_series.serie_id = in_serie_id;
	-- first get all scores for show in final
	select json_arrayagg(json_object('score', s_series.score, 'review', s_series.review, 'name', profiles.name))
	into results
	from score_series as s_series 
	join profiles on profiles.id = s_series.profile_id
	and s_series.serie_id = in_serie_id;
	-- verify if this profile has a review of this movie
	select exists(
		select s_series.id from score_series as s_series 
		where s_series.profile_id = in_profile_id and s_series.serie_id = in_serie_id
	) into flag;
	if flag then
		SELECT s_series.id, s_series.score, s_series.review, avg_score, results as results
		from score_series as s_series where s_series.profile_id = in_profile_id and s_series.serie_id = in_serie_id;
	else
		select null as id, null as score, null as review, avg_score, results;
	end if;
end //
DELIMITER ;