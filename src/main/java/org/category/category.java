package org.category;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.db.database;

public class category {
	public List<String> getCategories()
	{
		List<String> result=new ArrayList<>();
		try
		{
			database dm=new database();
		    Connection con=dm.getConnect();
		    Statement st=con.createStatement();
		    String querycheck="SELECT name FROM public.\"Category\"";
        	ResultSet rt=st.executeQuery(querycheck);
        	while(rt.next())
 		    {
 			  result.add(rt.getString("name"));
 			}
		}
	   catch (SQLException exception) {
		    }
        return result;
	}
	
	
	
}