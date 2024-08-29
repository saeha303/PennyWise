
#### Always run tomcat after you change the backend (.java) files
#### Always refresh the browser, use ctrl+F5

==== A single user can manage multiple people's wallet. Wallet type can be cash, account, card, mobile money. If not cash, there will be additional unique name, card number/account number/mobile number.

# **BIGGEST PROBLEM: DYNAMICALLY SHOW FILTERS**

============================================================DATABASE CONNECTION
1. Connect to database
2. install postgresql
3. install pgadmin gui
4. make a database, name it PennyWise, you will see a schema named public, create the tables inside it
5. run query for creating and inserting data, table creation serial- User->Category->Budget->Wallet->Expense->Income->RecurringExpenses, insert data after creating each table
6. take help of chateu gpteu or give me a message if shit doesn't work

FOR ARONNO:
1. change the recurring expenses table, first delete it and then run the 'create_recur_expense.sql' and 'insert_recur_expense.sql'.
2. the Reports and Budget pages are not done, start with that, take help from other pages for components, or for fresh samples keep the index.html
open on the browser from the 'NICE ADMIN' project and copy-paste whatever you need
3. if u can, implement exporting reports in json or pdf or whatever format is possible in Settings page
4. Later habibi... happy frontend journey
5. change any one of the budget tables end date to 31-8-2024, there is a little logical problem, I'll tell you later in meeting


python ./src/main/resources/python/api.py
python ./src/main/resources/python/data-generation.py
python ./src/main/resources/python/budget-training.py
python ./src/main/resources/python/budget-predict.py
.\myenv\Scripts\activate



