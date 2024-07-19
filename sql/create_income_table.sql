-- Table: public.Income

-- DROP TABLE IF EXISTS public."Income";

CREATE TABLE IF NOT EXISTS public."Income"
(
    id integer NOT NULL DEFAULT nextval('"Income_id_seq"'::regclass),
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    amount bigint NOT NULL,
    wallet character varying(255) COLLATE pg_catalog."default",
    note character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Income_username_fkey" FOREIGN KEY (username)
        REFERENCES public."User" (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Income"
    OWNER to postgres;