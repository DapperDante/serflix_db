const { expectObjectToHaveProperties } = require("./utils/testHelpers");

describe("Profile tests", () => {
	let idUser;
	let idProfile;
	const name = "TestProfile123";
	const img = "https://example.com/testprofile.jpg";
	const password = "TestPassword!123";
	const newPassword = "NewTestPassword!789";
	it("should create a new user for profile's test", done => {
		global.db.query(
			`CALL add_user("profiletestuser", "profiletestuser@example.com", "ProfileTestUserPassword!456");`,
			(error, results) => {
				if (error) {
					throw error;
				}
				const response = JSON.parse(results[0][0].response);
				expect(response.result.id).not.toBeNull();
				idUser = response.result.id;
				done();
			}
		);
	});
	it("should add a profile and return a valid profile ID", done => {
		global.db.query(`CALL add_profile(${idUser}, "${name}", "${img}");`, (error, results) => {
			if (error) {
				throw error;
			}
			const response = JSON.parse(results[0][0].response);
			expect(response.result.id).not.toBeNull();
			idProfile = response.result.id;
			done();
		});
	});
	it("should retrieve the profile and contain all expected properties", done => {
		global.db.query(`CALL get_profile(${idProfile});`, (error, results) => {
			if (error) {
				throw error;
			}
			const response = JSON.parse(results[0][0].response);
			expectObjectToHaveProperties(response.result, [
				"id",
				"name",
				"img",
				"plan",
				"goals",
				"movies",
				"series",
				"password",
			]);
			done();
		});
	});
	it("should retrieve all profiles for the user", done => {
		global.db.query(`CALL get_all_profiles(${idUser});`, (error, results) => {
			if (error) {
				throw error;
			}
			const response = JSON.parse(results[0][0].response);
			expect(Array.isArray(response.result)).toBe(true);
			expectObjectToHaveProperties(response.result[0], [
				"id",
				"name",
				"img",
				"password"
			]);
			done();
		});
	});
	it("should add a password for the profile and confirm success", done => {
		global.db.query(`CALL add_profile_password(${idProfile}, "${password}");`);
		global.db.query(`CALL get_profile(${idProfile});`, (error, results) => {
			if (error) throw error;
			const response = JSON.parse(results[0][0].response);
			expect(response.result.password).not.toBeNull();
			done();
		});
	});
	it("should update the profile password and confirm success", done => {
		global.db.query(`CALL update_profile_password(${idProfile}, "${newPassword}");`);
		global.db.query(`CALL get_profile(${idProfile});`, (error, results) => {
			if (error) throw error;
			const response = JSON.parse(results[0][0].response);
			expect(response.result.password).toBe(newPassword);
			done();
		});
	});
	it("should delete the profile password and confirm success", done => {
		global.db.query(`CALL delete_profile_password(${idProfile});`);
		global.db.query(`CALL get_profile(${idProfile});`, (error, results) => {
			if (error) throw error;
			const response = JSON.parse(results[0][0].response);
			expect(response.result.password).toBeNull();
			done();
		});
	});
	
});
