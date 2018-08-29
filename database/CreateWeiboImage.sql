CREATE TABLE weibo_image (
	weibo_id INT8 PRIMARY KEY,
	image_hash CHAR ( 64 ) NOT NULL,
	--weibo_image_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT weibo_image_weibo_id_foreign_key FOREIGN KEY (weibo_id) REFERENCES public.weibo (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT weibo_image_image_hash_foreign_key FOREIGN KEY (image_hash) REFERENCES public.image (image_hash) ON DELETE CASCADE ON UPDATE CASCADE
);

/* 主键已经包含 UNIQUE INDEX 索引*/
CREATE UNIQUE INDEX weibo_image_weibo_id_uindex ON PUBLIC.weibo_image ( weibo_id );
CREATE INDEX weibo_image_image_hash_hindex ON PUBLIC.weibo_image USING hash ( image_hash );