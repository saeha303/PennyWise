-- Table: public.Recurring_expense

-- DROP TABLE IF EXISTS public."Recurring_expense";

CREATE TABLE IF NOT EXISTS public."Recurring_expense"
(
    id serial NOT NULL,
    title character varying(50) COLLATE pg_catalog."default" NOT NULL,
    time_of_remainder timestamp without time zone NOT NULL,
    amount bigint NOT NULL,
    details character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT "Recurring_expense_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Recurring_expense"
    OWNER to postgres;