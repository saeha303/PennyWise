-- Table: public.Wallet

-- DROP TABLE IF EXISTS public."Wallet";

CREATE TABLE IF NOT EXISTS public."Wallet"
(
    id serial NOT NULL ,
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL DEFAULT 'My Wallet'::character varying,
    amount bigint NOT NULL DEFAULT 0,
    type character varying(255) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Cash'::character varying,
    type_unique_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    type_unique_nunmber character varying(25) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Wallet_pkey" PRIMARY KEY (username,name,type,type_unique_name),
    UNIQUE (id),
    CONSTRAINT "Wallet_username_fkey" FOREIGN KEY (username)
        REFERENCES public."User" (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Wallet"
    OWNER to postgres;