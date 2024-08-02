-- Table: public.Expense

-- DROP TABLE IF EXISTS public."Expense";

CREATE TABLE IF NOT EXISTS public."Expense"
(
    id serial NOT NULL,
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category character varying(255) COLLATE pg_catalog."default" NOT NULL,
    note character varying(255) COLLATE pg_catalog."default" NOT NULL,
    wallet bigint NOT NULL,
    amount bigint NOT NULL,
    spent_on timestamp without time zone NOT NULL,
    CONSTRAINT "Expense_pkey" PRIMARY KEY (id),
    CONSTRAINT "Expense_category_fkey" FOREIGN KEY (category)
        REFERENCES public."Category" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Expense_username_fkey" FOREIGN KEY (username)
        REFERENCES public."User" (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Expense_wallet_fkey" FOREIGN KEY (wallet)
        REFERENCES public."Wallet" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Expense"
    OWNER to postgres;