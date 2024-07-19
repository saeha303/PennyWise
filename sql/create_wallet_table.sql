-- Table: public.Wallet

-- DROP TABLE IF EXISTS public."Wallet";

CREATE TABLE IF NOT EXISTS public."Wallet"
(
    id serial NOT NULL,
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Wallet_pkey" PRIMARY KEY (id),
    CONSTRAINT "Wallet_username_fkey" FOREIGN KEY (username)
        REFERENCES public."User" (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Wallet"
    OWNER to postgres;