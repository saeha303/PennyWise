import os
import psycopg2
import pandas as pd
class db:
    def __init__(self):
        # Connect to your PostgreSQL database
        # DATABASE_URL, e.g. postgresql://user:pass@host/PennyWise?sslmode=require (Neon).
        # Falls back to the original local database when unset.
        database_url = os.environ.get("DATABASE_URL")
        if database_url:
            self.conn = psycopg2.connect(database_url)
        else:
            self.conn = psycopg2.connect(
                dbname="PennyWise",
                user="postgres",
                password="pennywise",
                host="localhost",
                port="5432"
            )
    def executeQuery(self,query):
        df = pd.read_sql_query(query, self.conn)
        return df
