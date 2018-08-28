CREATE TABLE profile(
	id BIGSERIAL PRIMARY KEY,
	mail VARCHAR ( 128 ) UNIQUE NOT NULL,
	nickname VARCHAR ( 128 ) UNIQUE NOT NULL,
	introduction VARCHAR ( 512 ) NOT NULL DEFAULT '',
	profile_picture CHAR ( 64 ) NOT NULL DEFAULT '',
	salt CHAR ( 64 ) NOT NULL,
	salt_pass CHAR ( 64 ) NOT NULL,
	is_delete BOOL NOT NULL DEFAULT FALSE,
	profile_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL 
);
CREATE UNIQUE INDEX mail_uindex ON public.profile (mail);
CREATE UNIQUE INDEX nickname_uindex ON public.profile (nickname);