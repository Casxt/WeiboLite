CREATE TABLE image (
    image_hash CHAR ( 64 ) PRIMARY KEY,
    height INT4 NOT NULL CONSTRAINT positive_height CHECK (height > 0),
    width INT4 NOT NULL CONSTRAINT positive_width CHECK (width > 0),
    size INT4 NOT NULL CONSTRAINT positive_size CHECK (size > 0),
    is_delete BOOL NOT NULL DEFAULT FALSE
) ;
