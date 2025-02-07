DROP PROCEDURE IF EXISTS get_score_series;

delimiter //
create procedure `get_score_series`(in in_profile_id int, in in_serie_id int)
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
		select json_object('id', s_series.id, 'score', s_series.score, 'review', s_series.review) as review, avg_score, results 
		from score_series as s_series where s_series.profile_id = in_profile_id and s_series.serie_id = in_serie_id;
	else
		select json_object('id', null, 'score', null, 'review', null) as review, avg_score, results;
	end if;
end //
delimiter ;