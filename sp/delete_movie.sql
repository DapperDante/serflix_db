DROP PROCEDURE IF EXISTS delete_movie;

DELIMITER //
CREATE PROCEDURE delete_movie(IN in_profile_id INT, IN in_movie_id INT)
BEGIN
  DECLARE error_code INT;
  DECLARE result_json JSON;
  DECLARE message VARCHAR(255);

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    SET error_code = 45000;
    SET message = "Error";
  END;

  START TRANSACTION;

  DELETE FROM profile_movies 
  WHERE movie_id = in_movie_id AND profile_id = in_profile_id ;

  COMMIT;

  SELECT JSON_OBJECT(
    'message', message,
    'result', result_json,
    'error_code', error_code
  ) AS response;
END //
DELIMITER ;