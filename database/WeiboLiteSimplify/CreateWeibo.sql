
CREATE TABLE weibo (
	id BIGSERIAL PRIMARY KEY,
	user_id INT8 NOT NULL,
	content VARCHAR ( 255 ) NOT NULL,
	forward INT8 DEFAULT 0 NOT NULL,
	is_delete BOOL NOT NULL DEFAULT FALSE,
	weibo_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,

    CONSTRAINT user_id_foreign_key FOREIGN KEY (user_id) REFERENCES public.user (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT weibo_id_foreign_key FOREIGN KEY (forward) REFERENCES public.weibo (id) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE INDEX weibo_forward_index ON PUBLIC.weibo USING hash ( forward );
CREATE INDEX weibo_comment_user_id_hindex ON PUBLIC.weibo USING hash ( user_id );

/*
查询优化 ：
https://www.cnblogs.com/tangyanbo/p/6378741.html
*/