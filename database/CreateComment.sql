CREATE TABLE comment (
	id BIGSERIAL PRIMARY KEY,
	user_id BIGINT NOT NULL,
    weibo_id BIGINT NOT NULL,
    /*如果是其他评论的评论，才设置comment_id*/
    comment_id BIGINT DEFAULT NULL,
	comment VARCHAR ( 128 ) NOT NULL,
    is_delete BOOL NOT NULL DEFAULT FALSE,
	comment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    
    CONSTRAINT user_id_foreign_key FOREIGN KEY (user_id) REFERENCES public.profile (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT weibo_id_foreign_key FOREIGN KEY (weibo_id) REFERENCES public.weibo (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT comment_id_foreign_key FOREIGN KEY (comment_id) REFERENCES public.comment (id) ON DELETE CASCADE ON UPDATE CASCADE
);