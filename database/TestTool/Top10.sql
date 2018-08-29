SELECT  (SELECT COUNT(*) FROM "weibo") AS "weibo_count", COUNT(*) AS "comment_count" FROM "comment";
SELECT "weibo_id" ,COUNT(*) AS "count" FROM "comment" GROUP BY "weibo_id" ORDER BY "count" DESC LIMIT 10;

/*
给主键加索引之后删除更快了？
https://dba.stackexchange.com/questions/37034/very-slow-delete-in-postgresql-workaround
*/