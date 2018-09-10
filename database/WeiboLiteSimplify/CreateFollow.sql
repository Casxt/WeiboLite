CREATE TABLE follow (
	user_id INT8 NOT NULL,
	follow_id INT8 NOT NULL,
	is_delete BOOL NOT NULL DEFAULT FALSE,
	follow_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT user_follow_id_unique UNIQUE (user_id, follow_id),
	CONSTRAINT user_id_foreign_key FOREIGN KEY (user_id) REFERENCES public.user (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT follow_id_foreign_key FOREIGN KEY (follow_id) REFERENCES public.user (id) ON DELETE CASCADE ON UPDATE CASCADE
) ;
CREATE UNIQUE INDEX follow_user_id_follow_uindex ON public.follow_id (user_id, follow_id);