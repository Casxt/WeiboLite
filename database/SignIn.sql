--用户登陆，验证账户
SELECT salt, salt_pass FROM profile WHERE mail =?;

--重置密码
INSERT INTO reset_password (user_id, reset_code) VALUES (?, ?);

SELECT mail, reset_date FROM reset_password INNER JOIN profile ON profile.id=reset_password.user_id WHERE reset_code=?;