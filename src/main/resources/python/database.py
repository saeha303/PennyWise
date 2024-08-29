import psycopg2
import pandas as pd
class db:
    def __init__(self):
        # Connect to your PostgreSQL database
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
