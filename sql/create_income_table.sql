-- Table: public.Income

-- DROP TABLE IF EXISTS public."Income";

CREATE TABLE IF NOT EXISTS public."Income"
(
    id serial NOT NULL,
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    wallet bigint NOT NULL,
    amount bigint NOT NULL,
    note character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Income_pkey" PRIMARY KEY (id),
    CONSTRAINT "Income_username_fkey" FOREIGN KEY (username)
        REFERENCES public."User" (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Income_wallet_fkey" FOREIGN KEY (wallet)
        REFERENCES public."Wallet" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Income"
    OWNER to postgres;