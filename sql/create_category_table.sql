-- Table: public.Category

-- DROP TABLE IF EXISTS public."Category";

CREATE TABLE IF NOT EXISTS public."Category"
(
    id serial NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    color character varying(7) COLLATE pg_catalog."default",
    falls_under character varying(50) COLLATE pg_catalog."default" NOT NULL DEFAULT ''::character varying,
    CONSTRAINT "Category_pkey" PRIMARY KEY (name)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Category"
    OWNER to postgres;