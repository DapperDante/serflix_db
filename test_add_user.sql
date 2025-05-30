-- Test 1: Add a new user (should succeed)
CALL add_user('testuser', 'testuser@example.com', 'password123');

-- Test 2: Try to add the same user again (should fail with duplicate error)
CALL add_user('testuser', 'testuser@example.com', 'password123');
