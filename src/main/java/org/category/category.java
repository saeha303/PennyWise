package org.category;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import jdk.jfr.Category;
import org.db.database;

public class category {
	public int id;
	public String name,color;
	public List<category> getCategories()
	{
		List<category> result=new ArrayList<>();
		try
		{
			database dm=new database();
		    Connection con=dm.getConnect();
		    Statement st=con.createStatement();
		    String querycheck="SELECT * FROM public.\"Category\"";
        	ResultSet rt=st.executeQuery(querycheck);
        	while(rt.next())
 		    {
				 category c=new category();
				 c.id=rt.getInt("id");
				 c.name=rt.getString("name");
				 c.color=rt.getString("color");
 			  result.add(c);
 			}
		}
	   catch (SQLException exception) {
		    }
        return result;
	}
	
	
	
}