<!--**PennyWise**

A Simple Expense Tracker app helps users manage their personal finances by tracking their daily
expenses. This app is particularly useful for users who want to monitor their spending habits, set
budgets, and get insights into their financial health.

Creators:
1. Sumaiya Saeha
2. Debjany Ghosh Aronno

For details check out the attached pdf: PennyWise.pdf

Steps to follow:
1. Install tomcat to run the web application
2. Install postgresql for database
3. Install pgadmin4 to manage database
4. Run tomcat, PennyWiseApplication.java and api.py-->

# PennyWise - Expense Tracker with Smart AI Features

An advanced **Expense Tracker** application built with **Spring Boot**, **JSP**, and **PostgreSQL**, featuring AI-driven **Budget Recommendations** to enhance user experience and financial management.

[Watch demo video](https://youtu.be/oLC5Y84_blQ)

---

## Features

### Core Features
- **Daily Expense Logging:** Add, categorize, and annotate your daily expenses with ease.
- **Monthly Reports:** Generate detailed reports with visual insights like pie charts and bar graphs.
- **Recurring Expenses:** Set recurring expenses with automatic reminders and budget allocation.
- **Budget Monitoring:** Set monthly budgets, get notifications, and forecast expenses based on historical data.

### AI-Powered Features
<!-- - **Smart Search:** Process natural language queries such as _"show me the expenses in July"_ or _"find transport expenses last week"_ using **NLP**.-->
- **Budget Recommendations:** Personalized budget recommendations based on spending patterns using a trained **Random Forest Regressor**.

---

## Prerequisites

### Software Requirements
- Java 17+
- Tomcat Server
- Python 3.10+ (for ML model training)
- PostgreSQL

### Libraries and Frameworks
- Backend: Spring Boot
- ML: scikit-learn, pandas, numpy

---

## Setup

### 1. Clone the Repository
```bash
git clone https://github.com/saeha303/PennyWise.git

2. Install Tomcat to run the web application
3. Install PostgreSQL for database
4. Install pgadmin4 to manage the database
5. Run tomcat, PennyWiseApplication.java and api.py
