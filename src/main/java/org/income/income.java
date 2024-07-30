package org.income;

import org.db.database;
import org.expense.expense;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class income {
    public int id,amount,wallet;
    public String username, note;
    public int store(income newIncome) {
        Connection con = null;
        PreparedStatement pst = null;
        try {
            database dm = new database();
            con = dm.getConnect();
            String query="INSERT INTO public.\"Income\"(username, note, amount, wallet) VALUES ('"+newIncome.username+"','"+newIncome.note+"','"+newIncome.amount+"','"+newIncome.wallet+"');";
            System.out.println(query);
//			return 1;
            pst = con.prepareStatement("INSERT INTO public.\"Income\" (username, note, amount, wallet) VALUES (?, ?, ?, ?)");

            pst.setString(1, newIncome.username);
            pst.setString(2, newIncome.note);
            pst.setBigDecimal(3, BigDecimal.valueOf(newIncome.amount)); // Adjust if necessary
            pst.setBigDecimal(4, BigDecimal.valueOf(newIncome.wallet));

            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0 ? 1 : 0;
        } catch (SQLException exception) {
            exception.printStackTrace();
            return 3;
        } finally {
            // Close resources
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
