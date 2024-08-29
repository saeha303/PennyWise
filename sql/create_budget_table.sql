-- Table: public.Budget

-- DROP TABLE IF EXISTS public."Budget";

CREATE TABLE IF NOT EXISTS public."Budget"
(
    id serial NOT NULL,
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    wallet character varying(255) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    amount bigint NOT NULL,
    CONSTRAINT "Budget_pkey" PRIMARY KEY (username, wallet),
    CONSTRAINT "Budget_username_fkey" FOREIGN KEY (username)
        REFERENCES public."User" (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Budget"
    OWNER to postgres;
