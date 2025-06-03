const { expectObjectToHaveProperties, expectBaseStructure } = require("./utils/testHelpers");

describe("Movies Database Procedures", () => {
	let user = {
		id: null,
		username: "testuser",
		email: "testuser@example.com",
		password: "securepassword",
	};

	let profile = {
		id: null,
		name: "Test User",
		img: "https://example.com/avatar.png",
	};
	const idMovie = 256439;
	it("should create a new user for movie's testing", done => {
		global.db.query(
			`CALL add_user("${user.username}", "${user.email}", "${user.password}");`,
			(error, results) => {
				if (error) {
					throw error;
				}
				const response = JSON.parse(results[0][0].response);
				expectBaseStructure(response);
				expect(response.result.id).not.toBeNull();
				expect(response.error_code).toBeNull();
				user.id = response.result.id;
				done();
			}
		);
	});
	it("should create a new profile for movie's testing", done => {
		global.db.query(
			`CALL add_profile(${user.id}, "${profile.name}", "${profile.img}");`,
			(error, results) => {
				if (error) {
					throw error;
				}
				const response = JSON.parse(results[0][0].response);
				expectBaseStructure(response);
				expect(response.result.id).not.toBeNull();
				expect(response.error_code).toBeNull();
				profile.id = response.result.id;
				done();
			}
		);
	});
	it("should add a movie to the profile", done => {
		global.db.query(`CALL add_movie(${profile.id}, ${idMovie});`, (error, results) => {
			if (error) {
				throw error;
			}
			const response = JSON.parse(results[0][0].response);
			expectBaseStructure(response);
			expect(response.result.id).not.toBeNull();
			expect(response.error_code).toBeNull();
			expectObjectToHaveProperties(response.result, ["goal"]);
			done();
		});
	});
	it("should retrieve the list of movies for the profile", done => {
		global.db.query(`CALL get_all_movies(${profile.id});`, (error, results) => {
			if (error) {
				throw error;
			}
			const response = JSON.parse(results[0][0].response);
			expectBaseStructure(response);
			expect(Array.isArray(response.result)).toBe(true);
			expectObjectToHaveProperties(response.result[0], ["movie_id"]);
			done();
		});
	});
	it("should retrieve a specific movie from the profile", done => {
		global.db.query(`CALL get_movie(${profile.id}, ${idMovie});`, (error, results) => {
			if (error) {
				throw error;
			}
			const response = JSON.parse(results[0][0].response);
			expectBaseStructure(response);
			expectObjectToHaveProperties(response.result, ["id", "profile_id", "movie_id"]);
			done();
		});
	});
	it("shoudl add a score movie", done => {
		global.db.query(
			`CALL add_score_movie(${profile.id}, ${idMovie}, 4, "Excelent, but there are betters");`,
			(error, results) => {
				if (error) {
					throw error;
				}
				const response = JSON.parse(results[0][0].response);
				expectBaseStructure(response);
				expect(response.result.id).not.toBeNull();
				expect(response.error_code).toBeNull();
				done();
			}
		);
	});
	it("should retrieve the score of the movie", done => {
		global.db.query(`CALL get_score_movie(${profile.id}, ${idMovie}, 'America/mazatlan');`, (error, results) => {
			if (error) {
				throw error;
			}
			const response = JSON.parse(results[0][0].response);
			expectBaseStructure(response);
			expectObjectToHaveProperties(response.result, [
				"avg_score", 
				"scores",
				"its_score"
			]);
			expectObjectToHaveProperties(response.result.its_score, ['id', 'name', 'score', 'review', 'created_at']);
			done();
		});
	});
	it("should delete the movie from the profile", done => {
		global.db.query(`CALL delete_movie(${profile.id}, ${idMovie});`);
		global.db.query(`CALL get_movie(${profile.id}, ${idMovie});`, (error, results) => {
			if (error) {
				throw error;
			}
			const response = JSON.parse(results[0][0].response);
			expectBaseStructure(response);
			expect(response.result).toBeNull();
			expect(response.error_code).not.toBeNull();
			done();
		});
	});
});
