DROP PROCEDURE IF EXISTS add_log_passwords;

DELIMITER //
CREATE PROCEDURE `add_log_passwords`(in in_user_id int, in in_new_password varchar(100))
begin
	declare old_password varchar(100);
	select password into old_password from users
	where id = in_user_id;
	insert into log_passwords(user_id, old_password, new_password, timestamp)
	values (in_user_id, old_password, in_new_password, utc_timestamp);
end //
DELIMITER ;