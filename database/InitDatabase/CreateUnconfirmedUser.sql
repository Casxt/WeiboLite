CREATE TABLE unconfirmed_user (
	id BIGSERIAL PRIMARY KEY,
	mail VARCHAR ( 128 ) UNIQUE NOT NULL,
	nickname VARCHAR ( 128 ) UNIQUE NOT NULL,
	active_code CHAR ( 64 ) NOT NULL,
	salt CHAR ( 64 ) NOT NULL,
	salt_pass CHAR ( 64 ) NOT NULL,
	is_delete BOOL NOT NULL DEFAULT FALSE,
	sign_up_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE UNIQUE INDEX unconfirmed_user_mail_active_code_uindex ON public.unconfirmed_user (mail, active_code);