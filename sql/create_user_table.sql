CREATE TABLE public."User"
(
    id SERIAL NOT NULL,
    username CHARACTER VARYING(50) NOT NULL,
    email CHARACTER VARYING(255) NOT NULL,
    password_hash CHARACTER VARYING(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    first_name CHARACTER VARYING(50),
    last_name CHARACTER VARYING(50),
    profile_picture CHARACTER VARYING(255),
    date_of_birth DATE,
    PRIMARY KEY (id),
    UNIQUE (email),
    UNIQUE (username)  -- Adding unique constraint on username
);
ALTER TABLE IF EXISTS public."User"
    OWNER TO postgres;
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER update_user_updated_at
BEFORE UPDATE ON public."User"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();