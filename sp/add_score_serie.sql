DROP PROCEDURE IF EXISTS add_score_serie;

DELIMITER //
CREATE PROCEDURE add_score_serie(IN in_profile_id INT, IN in_serie_id INT, IN in_score TINYINT, IN in_review VARCHAR(100))
BEGIN
  DECLARE result_json JSON;
  DECLARE error_code INT;
  DECLARE message VARCHAR(255) DEFAULT 'Serie score added';

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN 
    SET error_code = 45000;
    SET message = 'Error';
  END;

  START TRANSACTION;

  INSERT INTO score_serie(profile_id, serie_id, score, review, created_at)
  VALUES (in_profile_id, in_serie_id, in_score, in_review, UTC_TIMESTAMP());

  COMMIT;

  SELECT JSON_OBJECT(
    'result', result_json,
    'error_code', error_code,
    'message', message
  ) AS response;
END //
DELIMITER ;