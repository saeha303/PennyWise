package org.expense;

import org.db.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class recurring {
    public int id, wallet, amount;

    @Override
    public String toString() {
        return "recurring{" +
                "id=" + id +
                ", wallet=" + wallet +
                ", amount=" + amount +
                ", username='" + username + '\'' +
                ", category='" + category + '\'' +
                ", details='" + details + '\'' +
                ", frequency='" + frequency + '\'' +
                ", start_date='" + start_date + '\'' +
                ", end_date='" + end_date + '\'' +
                ", time='" + time + '\'' +
                '}';
    }

    public String username, category, details, frequency,start_date,end_date,time;
    public List<recurring> getRecurExpenses(String username){
        List<recurring> result=new ArrayList<>();
        try
        {
            database dm=new database();
            Connection con=dm.getConnect();
            Statement st=con.createStatement();
            String querycheck="select * from public.\"Recurring_expense\" where username='"+username+"';";
            System.out.println(querycheck);
            ResultSet rt=st.executeQuery(querycheck);
            while(rt.next())
            {
                recurring w=new recurring();
                w.id=rt.getInt("id");
                w.category=rt.getString("category");
                w.amount=rt.getInt("amount");
                w.details=rt.getString("details");
                w.frequency=rt.getString("frequency");
                w.wallet=rt.getInt("wallet");
                w.username=rt.getString("username");//
                w.start_date=rt.getString("time_of_remainder").split(" ")[0];
                w.end_date=rt.getString("end_date");
                w.time=rt.getString("time_of_remainder").split(" ")[1];
                result.add(w);
            }
            System.out.println(result);
        }
        catch (SQLException exception) {
        }
        return result;
    }
}
