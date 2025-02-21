DROP PROCEDURE IF EXISTS get_serie;

delimiter //
create procedure `get_serie`(in in_profile_id int, in in_serie_id int)
begin
	call add_log_views(in_profile_id, in_serie_id, 'S');
	select serie_id from profile_series 
	where profile_id = in_profile_id 
	and serie_id = in_serie_id
	and delete_at is null;
end //
delimiter ;