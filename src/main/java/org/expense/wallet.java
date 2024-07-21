package org.expense;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.db.database;

public class wallet {
	public int id, amount;
	public String username, name, type, type_unique_name, type_unique_number;

    public wallet() {

    }
	public List<String> getWalletList(String username)
	{
		
		List<String> result=new ArrayList<>();
		try
		{
			database dm=new database();
		    Connection con=dm.getConnect();
		    Statement st=con.createStatement();
		    String querycheck="SELECT name FROM public.\"Wallet\" where username='"+username+"'";
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

	@Override
	public String toString() {
		return "wallet{" +
				"id=" + id +
				", amount=" + amount +
				", type_unique_number=" + type_unique_number +
				", username='" + username + '\'' +
				", name='" + name + '\'' +
				", type='" + type + '\'' +
				", type_unique_name='" + type_unique_name + '\'' +
				'}';
	}

	public List<wallet> getWallets(String username)
	{
		
		List<wallet> result=new ArrayList<>();
		try
		{
			database dm=new database();
		    Connection con=dm.getConnect();
		    Statement st=con.createStatement();
		    String querycheck="SELECT * FROM public.\"Wallet\" where username='"+username+"'";
        	ResultSet rt=st.executeQuery(querycheck);
        	while(rt.next())
 		    {

				wallet w=new wallet();
				w.id=rt.getInt("id");
				w.username=rt.getString("username");
				w.name=rt.getString("name");
				w.amount=rt.getInt("amount");
				w.type=rt.getString("type");
				w.type_unique_name=rt.getString("type_unique_name");
				w.type_unique_number=rt.getString("type_unique_nunmber");
 			  	result.add(w);
 			}
		}
	   catch (SQLException exception) {
		    }
        return result;
	}
	public int store(String username, String wallet, String amount, String type, String name, String number) {
        try {
            database dm = new database();
            Connection con = dm.getConnect();
            String query = "Insert into public.\"Wallet\"(username, name, amount, type,type_unique_name,type_unique_nunmber) values('" + username + "','" + wallet + "','" + amount + "','" + type + "','" + name +"','" + number + "')";
			System.out.println("hi1");
			System.out.println(query);
            Statement st = con.createStatement();
            String querycheck = "Select * from public.\"Wallet\" where username='" + username + "' and name='"+wallet+"' and type='"+type+"' and type_unique_name='"+name+"' and type_unique_nunmber='"+number+"'";
			System.out.println("hi2");
			System.out.println(querycheck);
            ResultSet rt = st.executeQuery(querycheck);
            if (rt.next()) {
                return (0);
            } else {
                st.executeUpdate(query);
                return (1);
            }
        } catch (SQLException exception) {
            return (3);
        }
    }
}