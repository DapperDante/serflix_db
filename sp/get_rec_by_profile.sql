DROP PROCEDURE IF EXISTS get_rec_by_profile;

DELIMITER //
create procedure `get_rec_by_profile`(in in_profile_id int)
begin 
	select (
			select json_object('item_id', item_id, 'type', type)
				from (
					select item_id, type from log_views
					where profile_id = in_profile_id
					order by timestamp desc 
					limit 1
				) as last_viewed 
		) as last_viewed, (
			select json_arrayagg(json_object('item_id', item_id, 'type', type))
				from (
					select item_id, type from log_views
					where profile_id = in_profile_id
					and item_id != (
						-- to avoid return same tupla if is last viewed of profile
						select item_id from log_views
						where profile_id = in_profile_id
						order by timestamp desc limit 1
					)
					group by item_id, type 
					order by COUNT(*) desc
					limit 5
				) as recommendations 
		) as recommendations;
end //
DELIMITER ;