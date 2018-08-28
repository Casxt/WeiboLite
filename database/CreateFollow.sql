CREATE TABLE follow (
	id BIGSERIAL PRIMARY KEY,
	user_id INT8 NOT NULL,
	follow INT8 NOT NULL,
	follow_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	is_delete BOOL NOT NULL DEFAULT FALSE,
	CONSTRAINT user_follow_unique UNIQUE (user_id, follow),
	CONSTRAINT user_id_foreign_key FOREIGN KEY (user_id) REFERENCES public.profile (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT follow_foreign_key FOREIGN KEY (follow) REFERENCES public.profile (id) ON DELETE CASCADE ON UPDATE CASCADE
) ;
CREATE UNIQUE INDEX user_follow_uindex ON public.follow (user_id, follow);