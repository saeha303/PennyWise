package org.expense;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.db.database;

public class expense {
	public int id, wallet, amount;
	public String username, category, note, spent_on;
	public List<expense> getRecentActivity(String username){
		List<expense> result=new ArrayList<>();

		Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        int month = now.get(Calendar.MONTH);
        int day=now.get(Calendar.DATE);
        String strMonthYear="", strMonthPrefix ="",strDayPrefix="";

        if(month <= 9 ){
            strMonthPrefix = "-0";
        }else{
            strMonthPrefix = "-";
        }
        if(day<=9){
            strDayPrefix = "-0";
        }else{
            strDayPrefix = "-";
        }
        strMonthYear =  new String(new StringBuilder()
                .append(year).append(strMonthPrefix).append(month + 1)         // Month is 0 based, just add 1
                .append(strDayPrefix).append(day));
		String lastMonth=new String(new StringBuilder()
				.append(year).append(strMonthPrefix).append(month)         // Month is 0 based, just add 1
				.append("-").append("01"));

		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			String querycheck="select name,category,public.\"Expense\".amount,spent_on from public.\"Expense\" join public.\"Wallet\" on public.\"Expense\".wallet=public.\"Wallet\".id where public.\"Expense\".username='"+username+"' and spent_on between '"+lastMonth+"' and '"+strMonthYear+"'";
			System.out.println(querycheck);
			ResultSet rt=st.executeQuery(querycheck);
			while(rt.next())
			{
				expense w=new expense();
				w.category=rt.getString("category");
				w.amount=rt.getInt("amount");
				w.note=rt.getString("name");//name
				w.spent_on=rt.getString("spent_on");
				result.add(w);
			}

			System.out.println(result);
		}
		catch (SQLException exception) {
		}
		return result;
	}

	public List<expense> getMonthlyReport(String username){
		List<expense> result=new ArrayList<>();

		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH);
		int day=now.get(Calendar.DATE);
		String strMonthYear="", strMonthPrefix ="",strDayPrefix="";

		if(month <= 9 ){
			strMonthPrefix = "-0";
		}else{
			strMonthPrefix = "-";
		}
		strMonthYear =  new String(new StringBuilder()
				.append(year).append(strMonthPrefix).append(month + 1)         // Month is 0 based, just add 1
				.append("-").append("01"));
		int lastDay=now.getMaximum(Calendar.DAY_OF_MONTH);
		String lastDayOfMonth =  new String(new StringBuilder()
				.append(year).append(strMonthPrefix).append(month + 1)         // Month is 0 based, just add 1
				.append("-").append(lastDay));
		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			String querycheck="select * from public.\"Expense\" where spent_on Between '"+strMonthYear+"' and '"+lastDayOfMonth+"'";
			ResultSet rt=st.executeQuery(querycheck);
			while(rt.next())
			{
				expense w=new expense();
				w.id=rt.getInt("id");
				w.username=rt.getString("username");
				w.category=rt.getString("category");
				w.amount=rt.getInt("amount");
				w.note=rt.getString("note");
				w.wallet=rt.getInt("wallet");
				w.spent_on=rt.getString("spent_on");
				result.add(w);
			}

			System.out.println(result);
		}
		catch (SQLException exception) {
		}
		return result;
	}

	public List<expense> getDailyDonutChart(String username,String wallet){
		List<expense> result=new ArrayList<>();

		Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        int month = now.get(Calendar.MONTH);
        int day=now.get(Calendar.DATE);
        String strMonthYear="", strMonthPrefix ="",strDayPrefix="";

        if(month <= 9 ){
            strMonthPrefix = "-0";
        }else{
            strMonthPrefix = "-";
        }
        if(day<=9){
            strDayPrefix = "-0";
        }else{
            strDayPrefix = "-";
        }
        strMonthYear =  new String(new StringBuilder()
                .append(year).append(strMonthPrefix).append(month + 1)         // Month is 0 based, just add 1
                .append(strDayPrefix).append(day));

		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			String querycheck="select category,color,sum(amount) as amount from public.\"Expense\" join public.\"Category\" on public.\"Expense\".category=public.\"Category\".name where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"') and spent_on='"+strMonthYear+"' group by category,color";
			System.out.println(querycheck);
			ResultSet rt=st.executeQuery(querycheck);
			while(rt.next())
			{
				expense w=new expense();
				w.category=rt.getString("category");
				w.amount=rt.getInt("amount");
				// just using the variables with the correct data type
				w.note=rt.getString("color");
				result.add(w);
			}

			System.out.println(result);
		}
		catch (SQLException exception) {
		}
		return result;
	}

	public String gntotalup(String username)
	{
		String ans="0";
		try
		{
			System.out.println(username);
			database dm=new database();
		    Connection con=dm.getConnect();
		    Statement st=con.createStatement();
		    String querycheck="SELECT sum(price) FROM main where username='"+ username +"'";
        	 ResultSet rt=st.executeQuery(querycheck);
        	 while(rt.next())
 		    {
 			  ans=rt.getString(1);
 			}
        	
 		   System.out.println(ans);
 		   return ans;
		}
	   catch (SQLException exception) {
		     
		     return ans;
		    }
	}
	public String total(String username){
		String ans="0";
		try
		{
			System.out.println(username);
			LocalDate date=now();
			database dm=new database();
		    Connection con=dm.getConnect();
		    Statement st=con.createStatement();
		    String querycheck="SELECT sum(price) FROM main where username='"+ username +"' and date='"+ date +"'";
        	 ResultSet rt=st.executeQuery(querycheck);
		   while(rt.next())
		    {
			  ans=rt.getString(1);
			}
		   System.out.println(ans);
		   return ans;
		    
		}
	   catch (SQLException exception) {
		     
		     return ans;
		    }
	}
	public int updmain(String username, String pname,String sector,String cost)
	{
		try
		{
			System.out.println(pname+username);
			LocalDate date=now();
			database dm=new database();
		    Connection con=dm.getConnect();
		    
		    Statement st=con.createStatement();
		    String querycheck="Select * from main where username='"+ username +"' and date='"+ date +"' and pname='"+ pname +"'";
        	 ResultSet rt=st.executeQuery(querycheck);
		   String query2="update main set sector=?,price=? where username='"+ username +"'and date='"+ date +"' and pname='"+ pname +"'";
		   if(rt.next())
		    {
			   PreparedStatement ps=con.prepareStatement(query2);
			   ps.setString(1,sector);
			   ps.setString(2, cost);
			   ps.executeUpdate();
		      return(1);
		    }
		    else
		    {
			return(0);
		   }
		}
	   catch (SQLException exception) {
		     
		     return(3);
		    }
	}
	public int deletemain(String pname,String username)
	{
		try
		{
			System.out.println(pname);
			database dm=new database();
		    Connection con=dm.getConnect();
		    Statement st=con.createStatement();
		    LocalDate date=now();
		    String querycheck="Select * from main where username='"+ username +"' and pname='"+ pname +"' and date='"+ date +"'";
        	ResultSet rt=st.executeQuery(querycheck);
		   String query2="delete from main where username='"+ username +"'and pname='"+ pname +"' and date='"+ date +"'";
		   if(rt.next())
		    {
			   st.executeUpdate(query2);
		       return(1);
		    }
		    else
		    {
			return(0);
		   }
		}
	   catch (SQLException exception) {
		     
		     return(3);
		    }
	}
	
	
	public int exp(String pname,String sector,String cost,String username) {
		try
		{
			System.out.println(pname+username);
			database dm=new database();
		    Connection con=dm.getConnect();
		    
		    LocalDate date=now();
		    String query="Insert into main values('" + pname + "','" + sector + "','" + cost + "','" + username + "','" + date + "')";
		    Statement st=con.createStatement();
		    String querycheck="Select * from main where pname='"+ pname +"' and username='"+ username +"' and date='"+ date +"'";
		    ResultSet rt=st.executeQuery(querycheck);
		    if(rt.next())
		    {
		      return(0);
		    }
		    else
		    {
			st.executeUpdate(query);
		     return(1);
		    }
         }
	   catch (SQLException exception) {
		     
		     return(3);
		    }
	}
	public List<List<String>> mdetails(String user)
	{
		List<List<String>> dum=new ArrayList<>();
		List<List<String>> gans=new ArrayList<>();
		List<String> ansn= new ArrayList<>();
		ansn.add("1");
		dum.add(ansn);
		try {
			database dm=new database();
	        Connection con=dm.getConnect();
	    
		    LocalDate date=now();
		    String query="Select * from main where username='"+ user +"'and date='"+ date +"'";
            Statement st= con.createStatement();
   		    ResultSet rt=st.executeQuery(query);
   		    
            while(rt.next())
            {
            	List<String>ans=new ArrayList<>();
            	ans.add(rt.getString("pname"));
            	ans.add(rt.getString("sector"));
            	ans.add(rt.getString("price"));
            	gans.add(ans);
            	
            }
            return gans;
		}
		catch (SQLException exception) {
		    
		    return dum;
		}
	}
	

	public LocalDate now() {
		return java.time.LocalDate.now();
	}

	
	
}