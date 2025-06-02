DROP TABLE IF EXISTS score_series;
DROP TABLE IF EXISTS score_movies;
DROP TABLE IF EXISTS profile_series;
DROP TABLE IF EXISTS profile_movies;
DROP TABLE IF EXISTS profile_goals;
DROP TABLE IF EXISTS log_views;
DROP TABLE IF EXISTS log_passwords;
DROP TABLE IF EXISTS goals;
DROP TABLE IF EXISTS profile_password;
DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS suscriptions;
DROP TABLE IF EXISTS log_username;
DROP TABLE IF EXISTS users;

SOURCE ./structure/./tables.structure.sql;
SOURCE ./structure/./index.structure.sql;
SOURCE ./embending_data.sql;
SOURCE ./update_all_sp.sql;
