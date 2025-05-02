DROP PROCEDURE IF EXISTS update_first_time;

DELIMITER //
CREATE PROCEDURE update_first_time(IN user_id INT)
BEGIN
    DECLARE result_json JSON;
    DECLARE message VARCHAR(255) DEFAULT 'Success';
    DECLARE error_code INT;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
        SET message = 'Error';
        SET error_code = 45000;
    END;

    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    BEGIN
        SET message = 'User not found';
        SET error_code = 1329;
    END;

    UPDATE users
    SET is_first_time = 0
    WHERE id = user_id;

    SELECT JSON_OBJECT(
        'result_json', result_json,
        'message', message,
        'error_code', error_code
    ) AS response;
END //
DELIMITER ;