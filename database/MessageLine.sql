-- 按时间倒序选出comment和weibo
SELECT 'comment' as type, id, comment_date as message_date FROM comment WHERE user_id IN (?...) AND is_dalete=FALSE
UNION ALL
SELECT 'weibo' as type, id, weibo_date as message_date FROM weibo WHERE user_id IN (?...) AND is_dalete=FALSE
ORDER BY message_date DESC LIMIT 20 OFFSET ?;

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
    LEFT JOIN profile AS pro ON com.user_id = pro.ID)
    LEFT JOIN profile AS pro2 ON com2.user_id = pro2.ID)
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