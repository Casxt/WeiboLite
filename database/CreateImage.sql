CREATE TABLE image (
	id BIGSERIAL PRIMARY KEY,
	user_id INT8 NOT NULL,
	image_hash CHAR ( 64 ) NOT NULL,
    height INT4 NOT NULL CONSTRAINT positive_height CHECK (height > 0),
    width INT4 NOT NULL CONSTRAINT positive_width CHECK (width > 0),
    size INT4 NOT NULL CONSTRAINT positive_size CHECK (size > 0),
    usage_count INT4 DEFAULT 0 NULL,
    is_delete BOOL NOT NULL DEFAULT FALSE,
	image_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_id_foreign_key FOREIGN KEY (user_id) REFERENCES public.profile (id) ON DELETE CASCADE ON UPDATE CASCADE
) ;
CREATE UNIQUE INDEX image_user_id_image_hash_uindex ON public.image (user_id,image_hash);