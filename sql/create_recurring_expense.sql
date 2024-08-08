-- Table: public.Recurring_expense

-- DROP TABLE IF EXISTS public."Recurring_expense";

CREATE TABLE IF NOT EXISTS public."Recurring_expense"
(
    id serial NOT NULL,
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    wallet bigint NOT NULL,
    amount bigint NOT NULL,
    category character varying(255) COLLATE pg_catalog."default" NOT NULL,
    frequency character varying(25) COLLATE pg_catalog."default" NOT NULL,
    start_date date NOT NULL,
    end_date date,--if to be continued for indefinite time, then null
    time_of_remainder timestamp without time zone NOT NULL,
    details character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT "Recurring_expense_pkey" PRIMARY KEY (id),
    FOREIGN KEY (category)
        REFERENCES public."Category" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (username)
        REFERENCES public."User" (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (wallet)
        REFERENCES public."Wallet" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Recurring_expense"
    OWNER to postgres;