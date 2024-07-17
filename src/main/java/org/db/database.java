package org.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class database{
	public static Connection conn=null;
	public Connection getConnect() throws SQLException
    {
        if (conn!= null) return conn;
        database dm=new database();
        return dm.getConnection();
    }
	public Connection getConnection() throws SQLException{
		try {
			String url = "jdbc:postgresql://localhost:5432/PennyWise";
			String user = "postgres";
			String password = "pennywise";
			System.out.println(url+", "+user+", "+password);
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("Connected to PostgreSQL server successfully.");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} catch (ClassNotFoundException ex) {
			ex.printStackTrace();
            }
		return conn;
	}
	
}