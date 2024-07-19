-- Table: public.Wallet

-- DROP TABLE IF EXISTS public."Wallet";

CREATE TABLE IF NOT EXISTS public."Wallet"
(
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    wallet_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    id integer NOT NULL DEFAULT nextval('"Wallet_id_seq"'::regclass),
    CONSTRAINT "Wallet_pkey" PRIMARY KEY (username, wallet_name),
    CONSTRAINT "Wallet_username_fkey" FOREIGN KEY (username)
        REFERENCES public."User" (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Wallet"
    OWNER to postgres;