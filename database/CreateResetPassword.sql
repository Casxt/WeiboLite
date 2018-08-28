
CREATE TABLE reset_password (
	id BIGSERIAL PRIMARY KEY,
	user_id INT UNIQUE NOT NULL,
	reset_code CHAR ( 64 ) NOT NULL,
	is_delete BOOL NOT NULL DEFAULT FALSE,
	reset_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.profile (id) ON DELETE CASCADE ON UPDATE CASCADE
) ;
CREATE UNIQUE INDEX user_reset_code_uindex ON public.reset_password (user_id, reset_code);