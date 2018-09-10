CREATE TABLE comment (
	id BIGSERIAL PRIMARY KEY,
	user_id BIGINT NOT NULL,
    weibo_id BIGINT NOT NULL,
    comment_id BIGINT DEFAULT 0 NOT NULL,
	comment VARCHAR ( 255 ) NOT NULL,
    is_delete BOOL NOT NULL DEFAULT FALSE,
	comment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    
    CONSTRAINT user_id_foreign_key FOREIGN KEY (user_id) REFERENCES public.user (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT weibo_id_foreign_key FOREIGN KEY (weibo_id) REFERENCES public.weibo (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT comment_id_foreign_key FOREIGN KEY (comment_id) REFERENCES public.comment (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX comment_comment_id_hindex ON PUBLIC.COMMENT USING hash ( comment_id );
CREATE INDEX comment_weibo_id_hindex ON PUBLIC.COMMENT USING hash ( weibo_id );
CREATE INDEX comment_user_id_hindex ON PUBLIC.COMMENT USING hash ( user_id );