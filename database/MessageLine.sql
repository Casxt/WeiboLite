-- 按时间倒序选出comment和weibo
SELECT 'comment' as type, id, comment as content, is_delete, comment_date as message_date FROM comment WHERE user_id IN (14,15)
UNION ALL
SELECT 'weibo' as type, id, content, is_delete, weibo_date as message_date FROM weibo WHERE user_id IN (14,15)
ORDER BY message_date DESC LIMIT 20 OFFSET 0;

SELECT id, content, forward, is_delete, weibo_date FROM weibo WHERE user_id IN (14,15) ORDER BY weibo_date DESC LIMIT 20 OFFSET 0;

SELECT id, content, forward, is_delete, weibo_date FROM weibo JOIN "user" u on weibo.user_id = u.id WHERE u.nickname=? ORDER BY weibo_date DESC LIMIT 20 OFFSET 0;

-- 获取weibo详情，之后在程序中判断forward_type，并再次获取引用详情
SELECT id, nickname, profile_picture, content, forward_type, forward FROM weibo JOIN profile ON weibo.user_id=profile.id WHERE id=?;
--获取微博图片
SELECT image_hash FROM weibo_image WHERE weibo_id=?;

-- 获取评论详情
SELECT nickname, comment, comment_id FROM comment JOIN profile ON comment.user_id=profile.id WHERE weibo_id=?;
--数据取出来后要进一步处理，comment_id换为 comment_to,或者直接使用下面的查询，但是速度会慢很多，考虑使用存储过程优化一下
--SELECT com.nickname, com.comment, com2.nickname AS comment_to FROM (SELECT comment.id AS id, nickname, comment, comment_id FROM comment JOIN profile ON comment.user_id=profile.id WHERE weibo_id=18) AS com Left JOIN (SELECT comment.id AS id, nickname FROM comment JOIN profile ON comment.user_id=profile.id WHERE weibo_id=18) AS com2 ON com2.id = com.comment_id;
--这个语句速度已经提升很多，跟直接select在同一级别http://2015.padjo.org/tutorials/babynames-and-college-salaries/045-self-joins-and-nested-joins/
SELECT
	pro.nickname,
	com.comment,
	pro2.nickname AS comment_to,
    com.comment_date
FROM
    (((comment AS com LEFT JOIN comment AS com2 ON com.comment_id = com2.id) 
    LEFT JOIN profile AS pro ON com.user_id = pro.id)
    LEFT JOIN profile AS pro2 ON com2.user_id = pro2.id)
	 WHERE com.weibo_id=1080 AND com.is_dalete=FALSE;


--发布微博
INSERT INTO weibo(user_id, content, forward_type, forward) VALUES (?, ?, ?, ?) RETURNING id;
--记录图片
INSERT INTO weibo_image(weibo_id, image_hash) VALUES (?, ?);

--发布评论
INSERT INTO comment (user_id, weibo_id, comment_id, comment) VALUES (?, ?, ?, ?);

--删除微博
UPDATE weibo set is_dalete=TRUE WHERE id=?;
--删除评论
UPDATE comment set is_dalete=TRUE WHERE id=?;

--获取关注信息
SELECT
	nickname,
	profile_picture,
	EXISTS(SELECT * FROM follow WHERE follow_id = 14 AND user_id=u.id) AS follow_me,
	EXISTS(SELECT * FROM follow WHERE follow_id = u.id AND user_id=14) AS my_follow
FROM
	( SELECT user_id AS ID FROM follow WHERE follow_id = 14 UNION SELECT follow_id AS ID FROM follow WHERE user_id = 14 ) AS f
	JOIN PUBLIC.USER AS u ON f.ID = u.ID;

SELECT
	weibo.ID AS ID,
	u.nickname AS nickname,
	u.profile_picture AS profile_picture,
	CONTENT,
	FORWARD,
	weibo.is_deleted AS is_deleted,
	weibo_date
FROM
	weibo
	INNER JOIN PUBLIC.USER u ON weibo.user_id = u.ID
ORDER BY
	comment_count DESC
	LIMIT 10 OFFSET 0;