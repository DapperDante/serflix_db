CREATE TABLE IF NOT EXISTS posters(
    id INT NOT NULL AUTO_INCREMENT, 
    url VARCHAR(150) NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS users(
	id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(70) NOT NULL UNIQUE,
    username VARCHAR(65) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    auth_status TIMESTAMP,
    inactive TIMESTAMP,
    is_first_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS plans(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    detail VARCHAR(100) NOT NULL,
    price_usd DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS suscriptions(
    id INT NOT NULL AUTO_INCREMENT,
    plan_id INT NOT NULL,
    user_id INT NOT NULL UNIQUE,
    PRIMARY KEY(id),
    FOREIGN KEY(plan_id) REFERENCES plans(id),
    FOREIGN KEY(user_id) REFERENCES users(id),
    CONSTRAINT unique_value UNIQUE(plan_id, user_id)
);
CREATE TABLE IF NOT EXISTS profiles(
	id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    name VARCHAR(65),
    img VARCHAR(100),
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);
CREATE TABLE IF NOT EXISTS profile_password(
    id INT NOT NULL AUTO_INCREMENT,
    profile_id INT NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(profile_id) REFERENCES profiles(id) 
);
CREATE TABLE IF NOT EXISTS goals(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    detail VARCHAR(40) NOT NULL,
    url VARCHAR(100) NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS log_username(
	id INT NOT NULL AUTO_INCREMENT,
	user_id INT NOT NULL,
	old_username VARCHAR(100),
	new_username VARCHAR(100),
	timestamp DATETIME NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(user_id) REFERENCES users(id)
);
CREATE TABLE IF NOT EXISTS log_views(
	id INT NOT NULL AUTO_INCREMENT,
	profile_id INT NOT NULL,
	item_id INT NOT NULL,
	type CHAR,
	timestamp DATETIME NOT NULL,
	PRIMARY KEY(id),
    FOREIGN KEY(profile_id) REFERENCES profiles(id),
	CHECK(TYPE IN ('M', 'S'))
);
CREATE TABLE IF NOT EXISTS profile_goals(
	id INT NOT NULL AUTO_INCREMENT,
    profile_id INT NOT NULL,
    goal_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(profile_id) REFERENCES profiles(id),
    FOREIGN KEY(goal_id) REFERENCES goals(id),
    CONSTRAINT unique_value UNIQUE(profile_id, goal_id)
);
CREATE TABLE IF NOT EXISTS profile_movies(
	id INT NOT NULL AUTO_INCREMENT,
    profile_id INT NOT NULL,
    movie_id INT NOT NULL,
    delete_at TIMESTAMP,
    PRIMARY KEY(id),
	FOREIGN KEY(profile_id) REFERENCES profiles(id),
    CONSTRAINT unique_value UNIQUE(profile_id, movie_id)
);
CREATE TABLE IF NOT EXISTS score_movies(
	id INT NOT NULL AUTO_INCREMENT,
    profile_id INT NOT NULL,
    movie_id INT NOT NULL,
    score TINYINT NOT NULL,
    review VARCHAR(100) NOT NULL,
    created_at TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY(profile_id) REFERENCES profiles(id),
    CONSTRAINT unique_value UNIQUE(profile_id, movie_id)
);
CREATE TABLE IF NOT EXISTS profile_series(
	id INT NOT NULL AUTO_INCREMENT,
    profile_id INT NOT NULL,
    serie_id INT NOT NULL,
    delete_at TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY(profile_id) REFERENCES profiles(id),
    CONSTRAINT unique_value UNIQUE(profile_id, serie_id)
);
CREATE TABLE IF NOT EXISTS score_series(
	id INT NOT NULL AUTO_INCREMENT,
    profile_id INT NOT NULL,
    serie_id INT NOT NULL,
    score TINYINT NOT NULL,
    review VARCHAR(100) NOT NULL,
    created_at TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY(profile_id) REFERENCES profiles(id),
    CONSTRAINT unique_value UNIQUE(profile_id, serie_id)
);