DROP PROCEDURE IF EXISTS get_all_movies;

DELIMITER //

CREATE PROCEDURE get_all_movies(IN in_profile_id INT)
BEGIN
  DECLARE result_json JSON;
  DECLARE message VARCHAR(255) DEFAULT 'Success';
  DECLARE error_code INT; 

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    SET message = 'Error';
    SET error_code = 45000;
  END;

  SELECT JSON_ARRAYAGG(
    JSON_OBJECT(
      'movie_id', movie_id
      )
  ) 
  INTO result_json
  FROM profile_movies
  WHERE profile_id = in_profile_id 
  AND delete_at IS NULL;

  SELECT JSON_OBJECT(
    'result', result_json,
    'message', message,
    'error_code', error_code
  ) AS response;
END //

DELIMITER ;