CREATE TYPE forward_type_enum as ENUM('Weibo','Comment','NoForward');
CREATE TABLE weibo (
	id BIGSERIAL PRIMARY KEY,
	user_id INT8 NOT NULL,
	content VARCHAR ( 512 ) NOT NULL,
    /*最多9张图片，记录格式 {imghash1,imghash2,...,imghashN}*/
	images CHAR(64)[] DEFAULT '{}' NOT NULL CHECK (array_length(images, 1) <= 9),
	forward_type forward_type_enum DEFAULT 'NoForward' NOT NULL,
	forward INT8 DEFAULT 0 NULL,
	is_delete BOOL NOT NULL DEFAULT FALSE,
	weibo_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,

    CONSTRAINT user_id_foreign_key FOREIGN KEY (user_id) REFERENCES public.profile (id) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE INDEX weibo_forward_index ON PUBLIC.weibo ( forward_type, FORWARD );
CREATE INDEX weibo_comment_user_id_hindex ON PUBLIC.weibo USING hash ( user_id );
/*
查询优化 ：
https://www.cnblogs.com/tangyanbo/p/6378741.html
*/