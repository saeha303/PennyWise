import psycopg2
import random
from datetime import datetime, timedelta
from database import db

db=db()
cur = db.conn.cursor()

# Sample data
users = "john_doe"  # Replace with actual usernames
categories = [
    "Groceries", "Vegetables, Fruits, Dairy and Meat", "Rent and Other Bills", "Transport",
    "Fuel", "Medical and Pharmacy Bill", "Outside Food", "Shopping", "Entertainment",
    "Salon and Beauty Products", "Gift", "Holidays", "Investments", "Gaming", "Kids", "Repair",
    "Sport", "Home", "Work", "Transfer", "Others"
]

notes = {
    "Groceries": ["Weekly grocery shopping", "Bought essentials", "Supermarket visit", "Organic products purchase"],
    "Vegetables, Fruits, Dairy and Meat": ["Farmers market veggies", "Fresh fruits for the week", "Dairy purchase", "Butcher shop visit"],
    "Rent and Other Bills": ["Monthly rent payment", "Electricity bill", "Internet bill", "Water bill"],
    "Transport": ["Bus fare", "Train ticket", "Taxi ride", "Public transport pass"],
    "Fuel": ["Filled up gas tank", "Diesel for car", "Motorbike fuel", "Fuel stop on the way"],
    "Medical and Pharmacy Bill": ["Prescription meds", "Doctor consultation", "Pharmacy visit", "Bought vitamins"],
    "Outside Food": ["Dinner at a restaurant", "Fast food", "Café visit", "Takeout meal"],
    "Shopping": ["Clothes shopping", "Bought electronics", "Gift for friend", "Online shopping spree"],
    "Entertainment": ["Movie tickets", "Concert ticket", "Streaming service subscription", "Bought a new game"],
    "Salon and Beauty Products": ["Haircut", "Salon visit", "Bought skincare products", "Manicure"],
    "Gift": ["Birthday gift", "Anniversary present", "Holiday gifts", "Thank you gift"],
    "Holidays": ["Booked hotel", "Flight ticket", "Vacation planning", "Holiday trip expenses"],
    "Investments": ["Bought stocks", "Investment in mutual funds", "Savings deposit", "Retirement fund contribution"],
    "Gaming": ["Bought a new game", "In-game purchases", "Gaming subscription", "Console upgrade"],
    "Kids": ["Bought toys", "School supplies", "Childcare fees", "Kids' clothes"],
    "Repair": ["Car repair", "Home appliance fix", "Gadget repair", "Furniture repair"],
    "Sport": ["Gym membership", "Bought sports equipment", "Fitness class", "Sports event ticket"],
    "Home": ["Bought home decor", "Furniture shopping", "Home improvement", "Gardening supplies"],
    "Work": ["Office supplies", "Work travel", "Business lunch", "Client meeting expenses"],
    "Transfer": ["Bank transfer", "Sent money to family", "Wire transfer fee", "Transferred funds to savings"],
    "Others": ["Miscellaneous expenses", "Unexpected costs", "Random purchase", "Other uncategorized spending"]
}

wallet_ids = [1, 9]  # Replace with actual wallet IDs
start_date = datetime(2024, 1, 1)
end_date = datetime(2024, 8, 31)
# Function to generate random expenses
def generate_random_datetime(start_date):
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    random_seconds = random.randint(0, 86400)  # Number of seconds in a day
    random_datetime = start_date + timedelta(days=random_days, seconds=random_seconds)
    return random_datetime.strftime('%Y-%m-%d %H:%M:%S')
def generate_expense():
    username = users
    category = random.choice(categories)
    note = random.choice(notes[category])
    wallet = random.choice(wallet_ids)
    amount = random.randint(10, 4000)
    spent_on = generate_random_datetime(start_date)
    # Fetch falls_under from the Category table
    cur.execute(
        """
        SELECT falls_under FROM public."Category" WHERE name = %s
        """, 
        (category,)
    )
    falls_under = cur.fetchone()[0]
    return username, category, note, wallet, amount, spent_on, falls_under
# Insert synthetic data into the Expense table
def insert_expenses(n):
    for _ in range(n):
        username, category, note, wallet, amount, spent_on,falls_under = generate_expense()
        cur.execute(
            """
            INSERT INTO public."Expense" (username, category, note, wallet, amount, spent_on)
            VALUES (%s, %s, %s, %s, %s, %s)
            """,
            (username, category, note, wallet, amount, spent_on)
        )
        # print("""
        #     INSERT INTO "Expense" (username, category, note, wallet, amount, spent_on)
        #     VALUES (%s, %s, %s, %s, %s, %s)
        #     """,(username, category, note, wallet, amount, spent_on))
    db.conn.commit()

# Generate and insert 1000 synthetic expense records
insert_expenses(1000)

# Close the connection
cur.close()
db.conn.close()
