const { expectObjectToHaveProperties, expectBaseStructure } = require("./utils/testHelpers");

describe("Series Database Procedures", () => {
	let user = {
		id: null,
		username: "newuser",
		email: "newuser@example.com",
		password: "newsecurepassword123",
	};

	let profile = {
		id: null,
		name: "Test User",
		img: "https://example.com/avatar.png",
	};
	const idSeries = 123456; // Example series ID

	it("should create a new user for series's testing", done => {
		global.db.query(
			`CALL add_user("${user.username}", "${user.email}", "${user.password}");`,
			(error, results) => {
				if (error) {
					throw error;
				}
				const response = JSON.parse(results[0][0].response);
				expectBaseStructure(response);
				expect(response.error_code).toBeNull();
				expect(response.result.id).not.toBeNull();
				user.id = response.result.id;
				done();
			}
		);
	});
	it("should create a new profile for series's testing", done => {
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
	it("should add a series to the profile", done => {
		global.db.query(`CALL add_serie(${profile.id}, ${idSeries});`, (error, results) => {
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
	it("should retrieve the list of series for the profile", done => {
		global.db.query(`CALL get_all_series(${profile.id});`, (error, results) => {
			if (error) {
				throw error;
			}
			const response = JSON.parse(results[0][0].response);
			expectBaseStructure(response);
			expect(Array.isArray(response.result)).toBe(true);
			expectObjectToHaveProperties(response.result[0], ["serie_id"]);
			done();
		});
	});
	it("should retrieve a specific series from the profile", done => {
		global.db.query(`CALL get_serie(${profile.id}, ${idSeries});`, (error, results) => {
			if (error) {
				throw error;
			}
			const response = JSON.parse(results[0][0].response);
			expectBaseStructure(response);
			expectObjectToHaveProperties(response.result, ["id", "profile_id", "serie_id"]);
			done();
		});
	});
	it("should add a score series", done => {
		global.db.query(
			`CALL add_score_serie(${profile.id}, ${idSeries}, 4, "Excellent, but there are better");`,
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
	it("should retrieve the score of the series", done => {
		global.db.query(
			`CALL get_score_serie(${profile.id}, ${idSeries}, 'America/mazatlan');`,
			(error, results) => {
				if (error) {
					throw error;
				}
				const response = JSON.parse(results[0][0].response);
				expectBaseStructure(response);
				expectObjectToHaveProperties(response.result, ["avg_score", "scores", "its_score"]);
				expectObjectToHaveProperties(response.result.its_score, [
					"id",
					"name",
					"score",
					"review",
					"created_at",
				]);
				done();
			}
		);
	});
	it("should delete the series from the profile", done => {
		global.db.query(`CALL delete_serie(${profile.id}, ${idSeries});`);
		global.db.query(`CALL get_serie(${profile.id}, ${idSeries});`, (error, results) => {
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
