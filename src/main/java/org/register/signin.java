package org.register;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.db.database;
import org.encrypt.pass;

public class signin {

    public String getname(String user) {
        try {
            database dm = new database();
            Connection con = dm.getConnect();
            String query = "Select name from public.\"User\" where username='" + user + "'";
            Statement st = con.createStatement();
            ResultSet rt = st.executeQuery(query);
            if (rt.next()) {
                String pas = rt.getString("name");
                //System.out.println(pas);
                return pas;
            } else {
                return "error";
            }
        } catch (SQLException exception) {
            return ("error");
        }
    }

    public int store(String name, String country, String phno, String username, String password) {
        try {
            System.out.println(name + country + phno + username + password);
            String enc = pass.encrypt(password, username);
            String pupd = "NO";
            database dm = new database();
            Connection con = dm.getConnect();
            String query = "Insert into User values('" + name + "','" + country + "','" + phno + "','" + username + "','" + enc + "','" + pupd + "')";
            Statement st = con.createStatement();
            String querycheck = "Select * from User where username='" + username + "'";
            ResultSet rt = st.executeQuery(querycheck);
            if (rt.next()) {
                return (0);
            } else {
                st.executeUpdate(query);

                return (1);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
            return (3);
        }
    }

    public int update(String name, String country, String phno, String username, String password) {
        try {
            System.out.println(name + country);
            database dm = new database();
            Connection con = dm.getConnect();
            Statement st = con.createStatement();
            String querycheck = "Select * from User where username='" + username + "'";
            String dec = pass.encrypt(password, username);
            ResultSet rt = st.executeQuery(querycheck);
            String query2 = "update User set name=?,country=?,phno=?,password_hash=? where username='" + username + "'";
            if (rt.next()) {
                PreparedStatement ps = con.prepareStatement(query2);
                ps.setString(1, name);
                ps.setString(2, country);
                ps.setString(3, phno);
                ps.setString(4, dec);
                ps.executeUpdate();

                return (1);
            } else {
                return (0);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
            return (3);
        }
    }

    public int plnupdate(String plan, String amount, String period, String stdate, String endate, String username) {
        try {
            System.out.println(plan + amount);
            database dm = new database();
            Connection con = dm.getConnect();
            Statement st = con.createStatement();
            String querycheck = "Select * from planboard where username='" + username + "'";
            ResultSet rt = st.executeQuery(querycheck);
            String query2 = "update planboard set plan=?,amount=?,period=?,stdate=?,endate=? where username='" + username + "'";
            if (rt.next()) {
                PreparedStatement ps = con.prepareStatement(query2);
                ps.setString(1, plan);
                ps.setString(2, amount);
                ps.setString(3, period);
                ps.setString(4, stdate);
                ps.setString(5, endate);
                ps.executeUpdate();

                return (1);
            } else {
                return (0);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
            return (3);
        }
    }

    public int onboard(String plan, String amount, String period, String stdate, String endate, String username) {
        try {
            database dm = new database();
            Connection con = dm.getConnect();
            String query = "Insert into planboard values('" + plan + "','" + amount + "','" + period + "','" + stdate + "','" + endate + "','" + username + "')";
            Statement st = con.createStatement();
            String querycheck = "Select * from planboard where username='" + username + "'";
            ResultSet rt = st.executeQuery(querycheck);
            String query2 = "update User set planupd='YES' where username='" + username + "'";
            if (rt.next()) {
                return (0);
            } else {
                st.executeUpdate(query);
                st.executeUpdate(query2);

                return (1);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
            return (3);
        }
    }

    public int validate(String user, String password) {
        try {
            database dm = new database();
            Connection con = dm.getConnect();
            String query = "Select password_hash from User where username='" + user + "'";
            Statement st = con.createStatement();
            ResultSet rt = st.executeQuery(query);
            if (rt.next()) {
                String pas = rt.getString("password");
                String dec = pass.decrypt(pas, user);
                if (dec.equals(password)) {

                    return (1);
                } else {
                    return (2);
                }
            } else {
                return (4);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
            return (3);
        }
    }

    public int validateCurrentPassword(String user, String currentPassword) {
        try {
            database dm = new database();
            Connection con = dm.getConnect();
            String query = "Select password_hash from public.\"User\" where username='" + user + "'";
            Statement st = con.createStatement();
            ResultSet rt = st.executeQuery(query);
            if (rt.next()) {
                String pas = rt.getString("password_hash");
                String dec = "";
                if(pas != null){
                    dec=pass.decrypt(pas, user);
                }
                if (dec.equals(currentPassword)) {
                    return 1; // Password matches
                } else {
                    return 2; // Password does not match
                }
            } else {
                return 4; // User not found
            }
        } catch (Exception exception) {
            exception.printStackTrace();
            return 3; // Error occurred
        }
    }

    public int changePassword(String user, String currentPassword, String newPassword, String reNewPassword) {
        int validationStatus = validateCurrentPassword(user, currentPassword);
        if (validationStatus == 1) {
            if (newPassword.equals(reNewPassword)) {
                return updatePassword(user, newPassword);
            } else {
                return 5; // New passwords do not match
            }
        } else {
            return validationStatus; // Return validation status
        }
    }

    public int updatePassword(String user, String newPassword) {
        try {
            String enc = pass.encrypt(newPassword, user);
			System.out.println(enc);
            database dm = new database();
            Connection con = dm.getConnect();
            String query = "Update public.\"User\" set password_hash=? where username=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, enc);
            ps.setString(2, user);
            ps.executeUpdate();
            return 1; // Password update successful
        } catch (Exception exception) {
            exception.printStackTrace();
            return 3; // Error occurred
        }
    }

}
