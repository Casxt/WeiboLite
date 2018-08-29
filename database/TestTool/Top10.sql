SELECT  (SELECT COUNT(*) FROM "weibo") AS "weibo_count", COUNT(*) AS "comment_count" FROM "comment";
SELECT "weibo_id" ,COUNT(*) AS "count" FROM "comment" GROUP BY "weibo_id" ORDER BY "count" DESC LIMIT 10;

/*填充comment_count*/

UPDATE weibo2 SET comment_count = COALESCE((SELECT COUNT(*) FROM comment GROUP BY weibo_id HAVING comment.weibo_id = weibo2.id),0);

CREATE INDEX "weibo_comment_count_index" ON "public"."weibo2" USING hash (
  "comment_count"
);

