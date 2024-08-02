table creation serial- User->Category->Budget->Wallet->Expense->Income
insert in User and Category
change password in john_doe



#### Always run tomcat after you change the backend (.java) files
#### Always refresh the browser, use ctrl+F5

==== A single user can manage multiple people's wallet. Wallet type can be cash, account, card, mobile money. If not cash, there will be additional unique name, card number/account number/mobile number.

# **BIGGEST PROBLEM: DYNAMICALLY SHOW FILTERS**

TODO:
DASHBOARD
1. Net worth in dashboard, make the bar half-circle if possible, ~~filter for wallet~~, dynamically change needed
2. New transaction, add type, type_unique_name in ui in expense and income tab, it will be in a serial, first pick wallet, then show type for that wallet, choose, then show type_unique_name, choose, transfer tab is there for ease of use, otherwise that alone is a category for expense, ~~exclude category from income~~, transfer tab also needs type, type_unique_name, wait for damn internet, too much to do here
3. ~~Top 3 expenses~~, ~~filter for today, this month, this year~~, if compare then do with last day, last month, last year, if data is not present then show that
4. report, filter for today, this month, this year, today is done, same for other two
5. ~~budget report~~
TRANSACTIONS
6. calendar and filter has to be done dynamically, wait for internet
WALLETS
7. how to reset popup
8. is there anything like react context to refresh?
REPORTS
9. Has some idea, wait for internet
BUDGET
10. Just like wallet, can't do more than that, will do more if possible 
SETTINGS
11. Data import, export and shit

NO AI, wait for internet
how to create endpoint

============================================================DATABASE CONNECTION
1. Connect to database
2. install postgresql
3. install pgadmin gui
4. make a database, name it PennyWise, you will see a schema named public, create the tables inside it
5. run query for creating and inserting data, table creation serial- User->Category->Budget->Wallet->Expense->Income->RecurringExpenses, insert data after creating each table
6. take help of chateu gpteu or give me a message if shit doesn't work





