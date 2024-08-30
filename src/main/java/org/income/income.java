package org.income;

import java.math.BigDecimal;
import java.sql.*;

import org.db.database;

public class income {
    public int id,amount,wallet;
    public String username, note;
    public int store(income newIncome) {
        Connection con = null;
        PreparedStatement pst = null;
        try {
            database dm = new database();
            con = dm.getConnect();

            // Insert the new income
            pst = con.prepareStatement("INSERT INTO public.\"Income\" (username, note, amount, wallet) VALUES (?, ?, ?, ?)");
            pst.setString(1, newIncome.username);
            pst.setString(2, newIncome.note);
            pst.setBigDecimal(3, BigDecimal.valueOf(newIncome.amount)); // Adjust if necessary
            pst.setBigDecimal(4, BigDecimal.valueOf(newIncome.wallet));

            int rowsAffected = pst.executeUpdate();

            // Check the current amount in the wallet
            String querycheck = "SELECT amount FROM public.\"Wallet\" WHERE username = ? AND id = ?";
            PreparedStatement pstCheck = con.prepareStatement(querycheck);
            pstCheck.setString(1, newIncome.username);
            pstCheck.setBigDecimal(2, BigDecimal.valueOf(newIncome.wallet));

            ResultSet rt = pstCheck.executeQuery();
            int amount = 0;
            if (rt.next()) {
                amount = rt.getInt("amount");
            }

            // Add the new income amount to the wallet amount
            amount += newIncome.amount;
            String updateQuery = "UPDATE public.\"Wallet\" SET amount = ? WHERE id = ?";
            PreparedStatement pstUpdate = con.prepareStatement(updateQuery);
            pstUpdate.setInt(1, amount);
            pstUpdate.setBigDecimal(2, BigDecimal.valueOf(newIncome.wallet));

            int updateRows = pstUpdate.executeUpdate();

            return rowsAffected > 0 && updateRows > 0 ? 1 : 0;

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
