DROP PROCEDURE IF EXISTS change_to_premium;

DELIMITER //
CREATE PROCEDURE change_to_premium(in in_user_id int)
BEGIN 
    DECLARE id_suscription_exists INT;
    SELECT id INTO id_suscription_exists FROM suscriptions WHERE user_id = in_user_id;
    IF id_suscription_exists THEN
        UPDATE suscriptions SET plan_id = 2 WHERE id_suscription = id_suscription_exists;
    ELSE
        INSERT INTO suscriptions (user_id, plan_id) VALUES (in_user_id, 2);
    END IF;
END //
DELIMITER ;