DROP PROCEDURE IF EXISTS get_rec;

delimiter //
create procedure `get_rec`()
begin 
	select item_id, type from log_views
	group by item_id, type
	order by COUNT(*) desc
	limit 5;
end //
delimiter ;