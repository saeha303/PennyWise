INSERT INTO public."Expense"(
	username, category, note, amount, wallet, spent_on)
	VALUES ('john_doe','Groceries','Soap,Detergent','160','1','2024-07-20');
INSERT INTO public."Expense"(
	username, category, note, amount, wallet, spent_on)
	VALUES ('john_doe','Shopping','Shirt','1500','9','2024-07-19');
INSERT INTO public."Expense"(
	username, category, note, amount, wallet, spent_on)
	VALUES ('jane_doe','Groceries','Soap,Detergent','170','2','2024-07-20');
INSERT INTO public."Expense"(
	username, category, note, amount, wallet, spent_on)
	VALUES ('jane_doe','Rent and Other Bills','Electricity','2000','10','2024-07-03');


	INSERT INTO public."Expense"(
	username, category, note, amount, wallet, spent_on)
	VALUES ('john_doe','Transport','Metro','100','1','2024-07-22');
INSERT INTO public."Expense"(
	username, category, note, amount, wallet, spent_on)
	VALUES ('john_doe','Fuel','Bike','1500','1','2024-07-22');
INSERT INTO public."Expense"(
	username, category, note, amount, wallet, spent_on)
	VALUES ('john_doe','Entertainment','Netflix','300','1','2024-07-22');
INSERT INTO public."Expense"(
	username, category, note, amount, wallet, spent_on)
	VALUES ('john_doe','Repair','Window','2000','1','2024-07-22');

UPDATE public."Expense"
SET spent_on = '2024-07-28'::date + spent_on::time
WHERE spent_on::date = '2024-07-22'
AND username = 'john_doe';