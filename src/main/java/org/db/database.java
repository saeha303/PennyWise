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
			// DATABASE_URL, e.g. postgresql://user:pass@host/PennyWise?sslmode=require (Neon).
			// Falls back to the original local database when unset.
			String url = "jdbc:postgresql://localhost:5432/PennyWise";
			String user = "postgres";
			String password = "pennywise";
			String dbUrl = System.getenv("DATABASE_URL");
			if (dbUrl != null && !dbUrl.isEmpty()) {
				java.net.URI uri = java.net.URI.create(dbUrl.replaceFirst("^postgres(ql)?://", "http://"));
				String[] creds = uri.getRawUserInfo().split(":", 2);
				user = java.net.URLDecoder.decode(creds[0], java.nio.charset.StandardCharsets.UTF_8);
				password = creds.length > 1 ? java.net.URLDecoder.decode(creds[1], java.nio.charset.StandardCharsets.UTF_8) : "";
				url = "jdbc:postgresql://" + uri.getHost() + (uri.getPort() > 0 ? ":" + uri.getPort() : "")
						+ uri.getRawPath() + (uri.getRawQuery() != null ? "?" + uri.getRawQuery() : "?sslmode=require");
			}
			System.out.println("Connecting to " + url + " as " + user);
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