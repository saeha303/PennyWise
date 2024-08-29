import psycopg2
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
import joblib
import os
from database import db

db=db()
# Query to fetch data from PostgreSQL
query = 'SELECT username, category, amount, spent_on, wallet FROM public."Expense"'
df = db.executeQuery(query)

# Preprocess the data
df['spent_on'] = pd.to_datetime(df['spent_on'])
df['month'] = df['spent_on'].dt.month
df['category'] = df['category'].astype('category').cat.codes
df['username_wallet'] = df['username'] + '_' + df['wallet'].astype(str)
df['username_wallet'] = df['username_wallet'].astype('category').cat.codes

# Prepare features and target variable
X = df[['username_wallet', 'category', 'month']]
y = df['amount']

# Split the data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train a model (RandomForest for simplicity)
model = RandomForestRegressor(n_estimators=100)
model.fit(X_train, y_train)

# Evaluate the model (optional)
print("Model score:", model.score(X_test, y_test))

# Save the model
model_path = os.path.join('src', 'main', 'resources', 'models', 'budget_model.pkl')
joblib.dump(model, model_path)

# Close the database connection
db.conn.close()
