
TRUNCATE TABLE posts, user_accounts RESTART IDENTITY;
-- TRUNCATE TABLE user_accounts RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO user_accounts (email_address, username) VALUES ('harry_styles@email.com', 'harry_styles');
INSERT INTO user_accounts (email_address, username) VALUES ('taylor_swift@email.com', 'taylor_swift');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('Harrys House', 'SONGSSSS', '5000', '1');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('Watermelon Sugar', 'Tastes like strawberries', '600', '1');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('You Belong With Me', 'Youre on the phone', '300', '2');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('Red', 'Losing you was blue', '400', '2');
