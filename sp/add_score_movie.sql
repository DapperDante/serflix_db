DROP PROCEDURE IF EXISTS add_score_movie;

DELIMITER //
CREATE PROCEDURE add_score_movie(IN in_profile_id INT, IN in_movie_id INT, IN in_score TINYINT, IN in_review VARCHAR(100))
BEGIN
  DECLARE result_json JSON;
  DECLARE error_code INT;
  DECLARE message VARCHAR(255) DEFAULT 'Movie score added';

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    SET error_code = 45000;
    SET message = 'Error';
  END;
  
  START TRANSACTION;

  INSERT INTO score_movies(profile_id, movie_id, score, review)
  VALUES (in_profile_id, in_movie_id, in_score, in_review);

  COMMIT;
  
  SELECT JSON_OBJECT(
    'result', result_json,
    'message', message,
    'error_code', error_code
  ) AS response;
END //
DELIMITER ;