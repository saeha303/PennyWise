-- Insert example for House rent
INSERT INTO public."Recurring_expense" (username, wallet, amount, category, frequency, start_date, end_date, time_of_remainder, details)
VALUES 
('john_doe', 1, 24000, 'Rent and Other Bills', 'Monthly', '2024-08-01', NULL, '2024-08-01 20:00:00', 'Excluding electricity, gas, water bill');

-- Insert example for Internet bill
INSERT INTO public."Recurring_expense" (username, wallet, amount, category, frequency, start_date, end_date, time_of_remainder, details)
VALUES 
('john_doe', 1, 2500, 'Rent and Other Bills', 'Monthly', '2024-08-02', NULL, '2024-08-02 20:00:00', 'Internet bill');

-- Insert example for Paper bill
INSERT INTO public."Recurring_expense" (username, wallet, amount, category, frequency, start_date, end_date, time_of_remainder, details)
VALUES 
('john_doe', 9, 300, 'Work', 'Monthly', '2024-08-01', NULL, '2024-08-01 07:00:00', 'Newspaper bill');
