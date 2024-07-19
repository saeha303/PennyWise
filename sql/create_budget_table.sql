-- Table: public.Budget

-- DROP TABLE IF EXISTS public."Budget";

CREATE TABLE IF NOT EXISTS public."Budget"
(
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    amount bigint NOT NULL,
    id serial NOT NULL,
    CONSTRAINT "Budget_pkey" PRIMARY KEY (username),
    CONSTRAINT "Budget_username_fkey" FOREIGN KEY (username)
        REFERENCES public."User" (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Budget"
    OWNER to postgres;