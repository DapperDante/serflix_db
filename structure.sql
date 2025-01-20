CREATE TABLE users(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    email VARCHAR(70) NOT NULL UNIQUE,
    username VARCHAR(65) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE profiles(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    user_id INT NOT NULL,
    name VARCHAR(65),
    img VARCHAR(100),
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);
CREATE TABLE goals(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(20) NOT NULL,
    detail VARCHAR(40) NOT NULL,
    url VARCHAR(100) NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE profile_goals(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    profile_id INT NOT NULL,
    goal_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(profile_id) REFERENCES profiles(id),
    FOREIGN KEY(goal_id) REFERENCES goals(id),
    unique(profile_id, goal_id)
);
CREATE TABLE profile_movies(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    profile_id INT NOT NULL,
    movie_id INT NOT NULL,
    is_delete BOOLEAN NOT NULL DEFAULT(0),
    PRIMARY KEY(id),
	FOREIGN KEY(profile_id) REFERENCES profiles(id),
    UNIQUE(profile_id, movie_id)
);
CREATE TABLE score_movies(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    profile_id INT NOT NULL,
    movie_id INT NOT NULL,
    score TINYINT NOT NULL,
    review VARCHAR(100) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(profile_id) REFERENCES profiles(id),
    UNIQUE(profile_id, movie_id)
);
CREATE TABLE profile_series(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    profile_id INT NOT NULL,
    serie_id INT NOT NULL,
    is_delete BOOLEAN NOT NULL DEFAULT(0),
    PRIMARY KEY(id),
    FOREIGN KEY(profile_id) REFERENCES profiles(id),
    UNIQUE(profile_id, serie_id)
);
CREATE TABLE score_series(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    profile_id INT NOT NULL,
    serie_id INT NOT NULL,
    score TINYINT NOT NULL,
    review VARCHAR(100) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(profile_id) REFERENCES profiles(id),
    UNIQUE(profile_id, serie_id)
);
















