require('dotenv').config({path: '.env.testing'});

module.exports = {
  databaseOptions: {
    host: process.env.DB_TEST_HOST,
    port: process.env.DB_TEST_PORT,
    user: process.env.DB_TEST_USER,
    password: process.env.DB_TEST_PASSWORD,
    database: process.env.DB_TEST_NAME
  },
  createDatabase: true,
  dbSchema: "start_new_db.sql",
  truncateDatabase: true
}