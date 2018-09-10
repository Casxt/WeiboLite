CREATE TABLE user(
	id BIGSERIAL PRIMARY KEY,
	mail VARCHAR ( 255 ) UNIQUE NOT NULL,
	nickname VARCHAR ( 255 ) UNIQUE NOT NULL,
	introduction VARCHAR ( 255 ) NOT NULL DEFAULT '',
	profile_picture CHAR ( 64 ) NOT NULL DEFAULT '',
	salt CHAR ( 64 ) NOT NULL,
	salt_pass CHAR ( 64 ) NOT NULL,
	is_delete BOOL NOT NULL DEFAULT FALSE,
	profile_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL 
);
CREATE UNIQUE INDEX profile_mail_uindex ON public.profile (mail);
CREATE UNIQUE INDEX profile_nickname_uindex ON public.profile (nickname);