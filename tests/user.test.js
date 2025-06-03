const { expectObjectToHaveProperties, expectBaseStructure } = require("./utils/testHelpers");

describe("User tests", () => {
  let idUser;
  const username = "TestUser123";
  const email = "testuser123@example.com";
  const password = "testPassword!@#";
  const newPassword = "newTestPassword!@#";
  const updatedUsername = "UpdatedTestUser123";
  it("Should add a new user and return the user ID", done => {
    global.db.query(
      `CALL add_user("${username}", "${email}", "${password}");`,
      (error, results) => {
        if (error) {
          throw error;
        }
        const response = JSON.parse(results[0][0].response);
        expectBaseStructure(response);
        expect(response.result.id).not.toBeNull();
        idUser = response.result.id;
        done();
      }
    );
  });
  it("Should not allow duplicate username", done => {
    global.db.query(
      `CALL add_user("${username}", "anotheremail@example.com", "${password}");`,
      (error, results) => {
        if (error) {
          throw error;
        }
        const response = JSON.parse(results[0][0].response);
        expectBaseStructure(response);
        expect(response.error_code).not.toBeNull();
        done();
      }
    );
  });

  it("Should not allow duplicate email", done => {
    global.db.query(
      `CALL add_user("AnotherUser", "${email}", "${password}");`,
      (error, results) => {
        if (error) {
          throw error;
        }
        const response = JSON.parse(results[0][0].response);
        expectBaseStructure(response);
        expect(response.error_code).not.toBeNull();
        done();
      }
    );
  });
  it("Should authenticate the user successfully", done => {
    global.db.query(
      `CALL authenticate_user(${idUser});`,
      (error, results) => {
        if (error) {
          throw error;
        }
        const response = JSON.parse(results[0][0].response);
        expectBaseStructure(response);
        expect(response.error_code).toBeNull();
        done();
      }
    );
  });
  it("Should retrieve the user by username", done => {
    global.db.query(
      `CALL get_user_by_username("${username}");`,
      (error, results) => {
        if (error) {
          throw error;
        }
        const response = JSON.parse(results[0][0].response);
        expectBaseStructure(response);
        expect(response.result).not.toBeNull();
        expectObjectToHaveProperties(response.result, 
          [
            'id', 
            'username', 
            'email', 
            'password', 
            'is_first_time',
            'auth'
          ])
        expect(response.result.username).toBe(username);
        done();
      }
    );
  });
  it("Should retrieve the user by email", done => {
    global.db.query(
      `CALL get_user_by_email("${email}");`,
      (error, results) => {
        if (error) {
          throw error;
        }
        const response = JSON.parse(results[0][0].response);
        expectBaseStructure(response);
        expect(response.result).not.toBeNull();
        expect(response.result.email).toBe(email);
        done();
      }
    );
  });
  it("Should update the user's password successfully", done => {
    global.db.query(`CALL update_password(${idUser}, "${newPassword}");`);
    global.db.query(`CALL get_user_by_username("${username}");`,
      (error, results) => {
        if (error) {
          throw error;
        }
        const response = JSON.parse(results[0][0].response);
        expectBaseStructure(response);
        expect(response.result.password).toBe(newPassword);
        done();
      }
    )
  });
  it("Should update the user's username successfully", done => {
    global.db.query(`CALL update_username(${idUser}, "${updatedUsername}");`);
    global.db.query(`CALL get_user_by_username("${updatedUsername}");`,
      (error, results) => {
        if (error) {
          throw error;
        }
        const response = JSON.parse(results[0][0].response);
        expectBaseStructure(response);
        expect(response.result.username).toBe(updatedUsername);
        done();
      }
    );
  });
  it("Should update the user's first_time successfully", done => {
    global.db.query(`CALL update_first_time(${idUser});`);
    global.db.query(`CALL get_user_by_username("${updatedUsername}");`,
      (error, results) => {
        if (error) {
          throw error;
        }
        const response = JSON.parse(results[0][0].response);
        expectBaseStructure(response);
        expect(response.result.is_first_time).toBeNull();
        done();
      }
    );
  });
});