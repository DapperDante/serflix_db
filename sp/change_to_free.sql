DROP PROCEDURE IF EXISTS change_to_free;

DELIMITER //
CREATE PROCEDURE change_to_free(IN in_user_id INT)
BEGIN 
    UPDATE suscriptions SET plan_Id = 1 WHERE user_id = in_user_id;
END //
DELIMITER ;