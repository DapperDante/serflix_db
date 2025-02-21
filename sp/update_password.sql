DROP PROCEDURE IF EXISTS update_password;

delimiter //
create procedure `update_password`(in in_user_id int, in in_new_password VARCHAR(100))
sp:begin
	declare timestamp_last_log datetime;
	declare minimum_period datetime;
	declare is_there_log int;
	select COUNT(*) into is_there_log from log_passwords 
	where user_id = in_user_id;
	if is_there_log > 0 then
		select log.timestamp into timestamp_last_log from log_passwords as log
		where log.user_id = in_user_id order by log.timestamp desc limit 1;
		set minimum_period = date_sub(utc_timestamp(), interval 1 MONTH);
		if timestamp_last_log >= minimum_period then
			select 403 as status, "You can't change your password until pass the period (1 month)" as msg;
			leave sp;
		end if;
	end if;
	call add_log_passwords(in_user_id, in_new_password);
	update users
	set password = in_new_password
	where id = in_user_id;
	select 200 as status, "Password updated" as msg;
end //
delimiter //