DROP PROCEDURE IF EXISTS add_log_views;

delimiter //
create procedure `add_log_views`(in in_profile_id int, in in_item_id int, in in_type char)
begin
	insert into log_views(profile_id, item_id, type, timestamp)
	values (in_profile_id, in_item_id, in_type, utc_timestamp);
end //
delimiter ;