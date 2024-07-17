INSERT INTO User (username, email, first_name, last_name, date_of_birth)
VALUES ('john_doe', 'john.doe@example.com', 'John', 'Doe', '1990-01-01');
SELECT password_hash FROM public."User" where username='john_doe' --Single quote for string