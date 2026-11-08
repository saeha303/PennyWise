-- Creates (or resets) the shared "demo_user" account used by "Try as demo user" on the login page.
-- Copies john_doe's sample wallets, income, expenses, budgets and recurring expenses, shifting all
-- dates so the newest expense lands yesterday (the dashboard then has a current budget to compare).
-- Safe to re-run at any time to wipe whatever demo visitors changed:
--   psql "$DATABASE_URL" -f sql/create_demo_user.sql
BEGIN;

-- 1. wipe the previous demo data (children before wallets because of foreign keys)
DELETE FROM public."Expense"           WHERE username = 'demo_user';
DELETE FROM public."Income"            WHERE username = 'demo_user';
DELETE FROM public."Budget"            WHERE username = 'demo_user';
DELETE FROM public."Recurring_expense" WHERE username = 'demo_user';
DELETE FROM public."Wallet"            WHERE username = 'demo_user';

-- 2. the account itself (no password: it is only reachable through the demo button)
INSERT INTO public."User"(username, email, first_name, last_name)
VALUES ('demo_user', 'demo@pennywise.example', 'Demo', 'User')
ON CONFLICT (username) DO UPDATE SET password_hash = NULL;

-- 3. how far to move john_doe's 2024 sample dates forward
CREATE TEMP TABLE demo_shift ON COMMIT DROP AS
SELECT (date_trunc('day', now()) - interval '1 day') - date_trunc('day', max(spent_on)) AS delta
FROM public."Expense" WHERE username = 'john_doe';

-- 4. wallets, remembering old id -> new id so expenses/income point at the demo copies
CREATE TEMP TABLE demo_wallet_map ON COMMIT DROP AS
WITH src AS (
    SELECT * FROM public."Wallet" WHERE username = 'john_doe'
), ins AS (
    INSERT INTO public."Wallet"(username, name, amount, type, type_unique_name, type_unique_nunmber)
    SELECT 'demo_user', name, amount, type, type_unique_name, type_unique_nunmber FROM src
    RETURNING id, name, type, type_unique_name
)
SELECT src.id AS old_id, ins.id AS new_id
FROM src JOIN ins USING (name, type, type_unique_name);

INSERT INTO public."Expense"(username, category, note, wallet, amount, spent_on)
SELECT 'demo_user', e.category, e.note, m.new_id, e.amount, e.spent_on + s.delta
FROM public."Expense" e
JOIN demo_wallet_map m ON m.old_id = e.wallet
CROSS JOIN demo_shift s
WHERE e.username = 'john_doe';

INSERT INTO public."Income"(username, wallet, amount, note)
SELECT 'demo_user', m.new_id, i.amount, i.note
FROM public."Income" i
JOIN demo_wallet_map m ON m.old_id = i.wallet
WHERE i.username = 'john_doe';

INSERT INTO public."Budget"(username, wallet, start_date, end_date, amount)
SELECT 'demo_user', b.wallet, (b.start_date + s.delta)::date, (b.end_date + s.delta)::date, b.amount
FROM public."Budget" b CROSS JOIN demo_shift s
WHERE b.username = 'john_doe';

INSERT INTO public."Recurring_expense"(username, wallet, amount, category, frequency, start_date, end_date, time_of_remainder, details)
SELECT 'demo_user', r.wallet, r.amount, r.category, r.frequency,
       (r.start_date + s.delta)::date, (r.end_date + s.delta)::date, r.time_of_remainder + s.delta, r.details
FROM public."Recurring_expense" r CROSS JOIN demo_shift s
WHERE r.username = 'john_doe';

COMMIT;

SELECT 'wallets' AS what, count(*) FROM public."Wallet" WHERE username = 'demo_user'
UNION ALL SELECT 'expenses', count(*) FROM public."Expense" WHERE username = 'demo_user'
UNION ALL SELECT 'income', count(*) FROM public."Income" WHERE username = 'demo_user'
UNION ALL SELECT 'budgets', count(*) FROM public."Budget" WHERE username = 'demo_user'
UNION ALL SELECT 'recurring', count(*) FROM public."Recurring_expense" WHERE username = 'demo_user';
