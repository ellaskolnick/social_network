TRUNCATE TABLE posts, user_accounts RESTART IDENTITY;

INSERT INTO user_accounts (email_address, username) VALUES ('harry_styles@email.com', 'harry_styles');
INSERT INTO user_accounts (email_address, username) VALUES ('taylor_swift@email.com', 'taylor_swift');
