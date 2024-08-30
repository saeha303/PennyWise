package org.expense;

import org.db.database;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class recurring {
    public int id, amount;

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

    public String username, wallet, category, details, frequency,start_date,end_date,time;
    public String getName(String str){
        StringBuilder stringBuffer=new StringBuilder(str);
        int idx=stringBuffer.indexOf("\\");
        if(idx>=0)
            return new String(stringBuffer.deleteCharAt(idx));
        return str;
    }
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
                String str=rt.getString("wallet");
                StringBuilder stringBuffer=new StringBuilder(str);
                int idx=stringBuffer.indexOf("'");
                if(idx>=0)
                    stringBuffer.insert(idx,"\\");
                w.wallet=new String(stringBuffer);
                System.out.println(w.wallet);
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
    public int store(recurring newExpense) {
        Connection con = null;
        PreparedStatement pst = null;
        try {
            database dm = new database();
            con = dm.getConnect();
//			return 1;
            pst = con.prepareStatement("INSERT INTO public.\"Recurring_expense\" (username, wallet, amount, category, frequency, start_date, end_date, time_of_remainder, details)\n" +
                    "VALUES \n" +
                    "(?, ?, ?, ?, ?, ?, ?, ?, ?);");

            pst.setString(1, newExpense.username);
            pst.setString(2, newExpense.category);
            pst.setBigDecimal(3, BigDecimal.valueOf(newExpense.amount));
            pst.setString(4, newExpense.category); // Adjust if necessary
            pst.setString(5, newExpense.frequency);
            pst.setDate(6, Date.valueOf(newExpense.start_date)); // Adjust if necessary
            pst.setDate(7, Date.valueOf(newExpense.end_date));
            // Assuming newExpense.startDate is in the format "yyyy-MM-dd"
            String datePart = newExpense.start_date; // e.g., "2024-08-30"
            String timePart = newExpense.time; // e.g., "08:05:00"

// Parse the start date and time
            LocalDate startDate = LocalDate.parse(datePart);
            LocalTime time = LocalTime.parse(timePart);

// Combine the start date with the provided time
            LocalDateTime dateTime = LocalDateTime.of(startDate, time);

// Convert to Timestamp
            Timestamp timestamp = Timestamp.valueOf(dateTime);

// Use the timestamp in your prepared statement
            pst.setTimestamp(8, timestamp);
            pst.setString(9, newExpense.details);
            int rowsAffected = pst.executeUpdate();
            System.out.println(rowsAffected);
            return rowsAffected > 0 ? 1 : 0;
        } catch (SQLException exception) {
            exception.printStackTrace();
            return 3;
        } finally {
            // Close resources
            try {
                if (pst != null) pst.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
