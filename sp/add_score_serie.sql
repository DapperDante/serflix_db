DELIMITER //
CREATE PROCEDURE `get_score_series`(in in_profile_id int, in in_serie_id int)
begin
	SELECT s_series.id, s_series.score, s_series.review, (
	 select json_arrayagg(json_object('score', s_series.score,'review', s_series.review, 'name', profiles.name))
	 FROM score_series as s_series
	 JOIN profiles ON profiles.id = s_series.profile_id
	 AND s_series.serie_id = in_serie_id
	) as results from score_series as s_series where s_series.profile_id = in_profile_id and s_series.serie_id = in_serie_id;
end //
DELIMITER ;