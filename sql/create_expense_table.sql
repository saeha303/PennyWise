-- Table: public.Expense

-- DROP TABLE IF EXISTS public."Expense";

CREATE TABLE IF NOT EXISTS public."Expense"
(
    id integer NOT NULL DEFAULT nextval('"Expense_id_seq"'::regclass),
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    wallet character varying(255) COLLATE pg_catalog."default",
    category character varying(255) COLLATE pg_catalog."default" NOT NULL,
    note character varying(255) COLLATE pg_catalog."default" NOT NULL,
    date date NOT NULL,
    CONSTRAINT "Expense_pkey" PRIMARY KEY (id),
    CONSTRAINT "Expense_category_fkey" FOREIGN KEY (category)
        REFERENCES public."Category" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Expense_username_fkey" FOREIGN KEY (username)
        REFERENCES public."User" (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Expense"
    OWNER to postgres;