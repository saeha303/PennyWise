package org.expense;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.db.database;

public class budget {
	public int id, wallet, amount;
	public String username, startDate,endDate;
//	there can be only one ongoing budget
	public String getToday(){
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
		return strMonthYear;
	}
	public String correctApostrophe(String str){
		String[] temp=str.split("'");
		if(temp.length>1){
			str=temp[0];
			System.out.println(temp.length);
			for(int i=1;i<temp.length;i++){
				str+="''"+temp[i];
			}
		}
		return str;
	}
	public budget getBudget(String username,String wallet){
		budget b=new budget();
		String strMonthYear=getToday();
		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			wallet=correctApostrophe(wallet);
			String querycheck="select * from public.\"Budget\" where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"') and '"+strMonthYear+"' between start_date and end_date";
			System.out.println(querycheck);
			ResultSet rt=st.executeQuery(querycheck);
			if(rt.next())
			{
				b.id=rt.getInt("id");
				b.username=rt.getString("username");
				b.wallet=rt.getInt("wallet");
				b.startDate=rt.getString("start_date");
				b.endDate=rt.getString("end_date");
				b.amount=rt.getInt("amount");
			}

			System.out.println(b);
		}
		catch (SQLException exception) {
		}
		return b;
	}

	public List<String> getStartEndDate(String username,String wallet){
		List<String> result=new ArrayList<>();

		String strMonthYear=getToday();

		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			wallet=correctApostrophe(wallet);
			String querycheck="select start_date,end_date from public.\"Budget\" where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"') and '"+strMonthYear+"' between start_date and end_date";
			System.out.println(querycheck);
			ResultSet rt=st.executeQuery(querycheck);
			if(rt.next())
			{
				result.add(0,rt.getString("start_date"));
				result.add(1,rt.getString("end_date"));
			}

			System.out.println(result);
		}
		catch (SQLException exception) {
		}
		return result;
	}

	@Override
	public String toString() {
		return "budget{" +
				"id=" + id +
				", wallet=" + wallet +
				", amount=" + amount +
				", username='" + username + '\'' +
				", startDate='" + startDate + '\'' +
				", endDate='" + endDate + '\'' +
				'}';
	}

	public List<budget> getActualSpending(String username, String wallet){
//		budget b=new budget();
		List<budget> result=new ArrayList<>();
		List<String> b_list=new budget().getStartEndDate(username,wallet);
		String strMonthYear=getToday();
		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			wallet=correctApostrophe(wallet);
			String querycheck="select falls_under,sum(amount) as amount from public.\"Expense\" join public.\"Category\" on public.\"Expense\".category=public.\"Category\".name where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"') and spent_on between '"+b_list.get(0)+"' and '"+b_list.get(1)+"' group by falls_under  order by falls_under asc";
			System.out.println(querycheck);
			ResultSet rt=st.executeQuery(querycheck);
			while(rt.next())
			{
				budget b=new budget();
				b.wallet=rt.getInt("amount");
				b.startDate=rt.getString("falls_under");//using as falls_under
				result.add(b);
			}

			System.out.println(result);
		}
		catch (SQLException exception) {
		}
		return result;
	}
}