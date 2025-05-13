CREATE INDEX idx_unique_item ON log_views(profile_id, item_id, type);
CREATE INDEX idx_unique_item ON profile_movies(profile_id, movie_id);
CREATE INDEX idx_unique_item ON profile_series(profile_id, serie_id);
CREATE INDEX idx_unique_item ON score_series(profile_id, serie_id);
CREATE INDEX idx_unique_item ON score_movies(profile_id, movie_id);
CREATE INDEX idx_unique_item ON profile_goals(profile_id, goal_id);