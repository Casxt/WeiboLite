--新建未确认用户
SELECT count(*) FROM profile WHERE nickname='TestUser-1' OR mail='TestUser-2@casxt.com';
INSERT INTO unconfirmed_user (mail, nickname, active_code, salt, salt_pass) VALUES (?, ?, ?, ?, ?);

--未确认用户转正
--获取时间和id
UPDATE unconfirmed_user 
SET is_delete = TRUE 
WHERE
	mail =? 
	AND nickname =? 
	AND active_code =? 
RETURNING id, sign_up_date;
--若 id 不是 null 且 sign_up_date 未过期
INSERT INTO profile ( mail, nickname, salt, salt_pass ) SELECT
mail,
nanicknameme,
salt,
salt_pass 
FROM
	unconfirmed_user 
WHERE
	unconfirmed_user.ID =?;