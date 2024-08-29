from flask import Flask, request, jsonify
import joblib
import pandas as pd
import os
from database import db
app = Flask(__name__)


db=db()

@app.route('/predict-budget', methods=['POST'])
def predict_budget():
    # Load data from the database
    query = '''
    SELECT e.username, e.amount, e.spent_on, e.wallet, c.falls_under 
    FROM public."Expense" e
    JOIN public."Category" c ON e.category = c.name
    '''
    df = db.executeQuery(query)

    # Create the username_wallet feature for the existing data
    df['username_wallet'] = df['username'] + '_' + df['wallet'].astype(str)
    df['username_wallet'] = df['username_wallet'].astype('category')

    # Aggregate expenses by super category
    df_super_category = df.groupby(['username_wallet', 'falls_under', df['spent_on'].dt.month])['amount'].sum().reset_index()

    # Load the trained model
    model_path = os.path.join('src', 'main', 'resources', 'models', 'budget_model.pkl')
    model = joblib.load(model_path)

    # Define the unique categories and codes used during training
    unique_wallets = df['username_wallet'].astype('category').cat.categories
    unique_super_categories = df_super_category['falls_under'].astype('category').cat.categories
    data=request.json
    user = data['username']
    wallet = data['wallet']
    month = data['month']

    # Prepare the username_wallet feature for prediction
    user_wallet = user + '_' + str(wallet)

    user_wallet_code = pd.Categorical([user_wallet], categories=unique_wallets).codes[0]

    # Initialize a dictionary to store predictions for all super categories
    predicted_budgets = {}

    # Loop through all super categories to make predictions
    for super_category in unique_super_categories:
        # Get the super category code
        super_category_code = pd.Categorical([super_category], categories=unique_super_categories).codes[0]

        # Prepare input features
        input_features = [[user_wallet_code, super_category_code, month]]
        predicted_budget = model.predict(input_features)

        # Store the prediction in the dictionary
        predicted_budgets[super_category] = predicted_budget[0]

    # Close the database connection
    # db.conn.close()
    print(predicted_budgets)
    # Return the prediction as a JSON response
    return jsonify(predicted_budgets)

if __name__ == '__main__':
    app.run(port=5000)
