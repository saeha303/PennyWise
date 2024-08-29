package org.expense;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.db.database;

public class expense {
	public int id, wallet, amount;
	public String username, category, note, spent_on;
	int[] arr={31,29,31,30,31,30,31,31,30,31,30,31};
	List<Integer> dayOfMonth=new ArrayList<>();
	public String correctApostrophe(String str){
		String[] temp=str.split("'");
		if(temp.length>1){
			str=temp[0];
			for(int i=1;i<temp.length;i++){
				str+="''"+temp[i];
			}
		}
		return str;
	}
	public void fillDayOfMonth(){
		for(int i=0;i<arr.length;i++){
			if(i==1){
				Calendar now=Calendar.getInstance();
				int last=now.getMaximum(Calendar.DAY_OF_YEAR);
				if(last==365){
					dayOfMonth.add(28);
				}else {
					dayOfMonth.add(29);
				}
				continue;
			}
			dayOfMonth.add(arr[i]);
		}
	}
	@Override
	public String toString() {
		return "expense{" +
				"id=" + id +
				", wallet=" + wallet +
				", amount=" + amount +
				", username='" + username + '\'' +
				", category='" + category + '\'' +
				", note='" + note + '\'' +
				", spent_on='" + spent_on + '\'' +
				'}';
	}

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
	public String getYesterday(){
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
		if(day-1<=9){
			strDayPrefix = "-0";
		}else{
			strDayPrefix = "-";
		}
		strMonthYear =  new String(new StringBuilder()
				.append(year).append(strMonthPrefix).append(month + 1)         // Month is 0 based, just add 1
				.append(strDayPrefix).append(day-1));
		return strMonthYear;
	}
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
				.append(strDayPrefix).append(day).append(" 23:59:59"));
		String lastMonth=new String(new StringBuilder()
				.append(year).append(strMonthPrefix).append(month)         // Month is 0 based, just add 1
				.append("-").append("01").append(" 00:00:00"));

		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			String querycheck="select name,category,public.\"Expense\".amount,spent_on from public.\"Expense\" join public.\"Wallet\" on public.\"Expense\".wallet=public.\"Wallet\".id where public.\"Expense\".username='"+username+"' and spent_on between '"+lastMonth+"' and '"+strMonthYear+"'  LIMIT 10;";
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

		}
		catch (SQLException exception) {
		}
		return result;
	}
	public List<expense> getExpenseReportWithin(String username,String wallet,String start, String end){
		List<expense> result=new ArrayList<>();

//		fillDayOfMonth();
//		String[] startSplit=start.split("-");
//		String[] endSplit=end.split("-");
//		int diff=Integer.parseInt(endSplit[2])-Integer.parseInt(startSplit[2]);
//		System.out.println(diff);
//		String compareMonth="",compareYear="",_start="",_end="";
//		if(diff==27||diff==28||diff==29||diff==30){
//			_start=
//			compareMonth="select category,color,sum(amount) as amount from public.\"Expense\" join public.\"Category\" on public.\"Expense\".category=public.\"Category\".name where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"') and spent_on between '"+_start+"' and '"+_end+"' group by category,color order by amount desc union";
//		}
		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			wallet=correctApostrophe(wallet);
			String querycheck="select category,color,sum(amount) as amount from public.\"Expense\" join public.\"Category\" on public.\"Expense\".category=public.\"Category\".name where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"') and spent_on between '"+start+" 00:00:00' and '"+end+" 23:59:59' group by category,color order by amount desc";
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

		}
		catch (SQLException exception) {
		}
		return result;
	}
	public List<expense> getDailyDonutChart(String username,String wallet){
		List<expense> result=new ArrayList<>();

		String strMonthYear=getToday();

		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			wallet=correctApostrophe(wallet);
			String querycheck="select category,color,sum(amount) as amount from public.\"Expense\" join public.\"Category\" on public.\"Expense\".category=public.\"Category\".name where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"') and spent_on::date='"+strMonthYear+"' group by category,color order by amount desc";
			ResultSet rt=st.executeQuery(querycheck);
			while(rt.next())
			{
				expense w=new expense();
				w.category=rt.getString("category");
				w.amount=rt.getInt("amount");
				// just using the variables with the correct data type
				w.note=rt.getString("color");
				if(result.size()<3){
					w.wallet=compareMonthlySpending(w.category,username,wallet);
				}
				result.add(w);
			}
		}
		catch (SQLException exception) {
		}
		return result;
	}
	public List<expense> getMonthlyBar(String username,String wallet, String month){
		List<expense> result=new ArrayList<>();
		int m=Integer.valueOf(month);
		m++;
		String strMonthPrefix="";
		if(m <= 9 ){
			strMonthPrefix = "0";
		}
		strMonthPrefix+=Integer.toString(m);
		System.out.println(strMonthPrefix);
		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			wallet=correctApostrophe(wallet);
			String querycheck="select falls_under, SUM(e.amount) AS total_expense from public.\"Expense\" e join public.\"Category\" c on e.category=c.name where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"') and EXTRACT(MONTH FROM e.spent_on) = "+strMonthPrefix+" group by c.falls_under;";
			System.out.println(querycheck);
			ResultSet rt=st.executeQuery(querycheck);
			while(rt.next())
			{
				System.out.println("nope");
				expense w=new expense();
				w.category=rt.getString("falls_under");
				w.amount=rt.getInt("total_expense");
				result.add(w);
			}
			System.out.println("out:");
			System.out.println(result);
		}
		catch (SQLException exception) {
		}
		return result;
	}
	public List<Integer> getNetWorth(String username,String wallet){
		List<Integer> result=new ArrayList<>();

		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			wallet=correctApostrophe(wallet);
			String querycheck="select sum(amount) as result from public.\"Expense\" where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"') union " +
					"select sum(amount) from public.\"Income\" where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"');";
			ResultSet rt=st.executeQuery(querycheck);
			while(rt.next())
			{
				result.add(rt.getInt("result"));
			}
			double sum=result.get(0)+result.get(1);
			double first=result.get(0)/sum;
			double second=result.get(1)/sum;//income percentage
			int e_percentage=(int)Math.ceil(first*100);
			result.add(e_percentage);
			result.add(100-e_percentage);
		}
		catch (SQLException exception) {
		}
		return result;
	}
	public int store(expense newExpense) {
		Connection con = null;
		PreparedStatement pst = null;
		try {
			database dm = new database();
			con = dm.getConnect();
			String query="INSERT INTO public.\"Expense\"(username, category, note, amount, wallet, spent_on) VALUES ('"+newExpense.username+"','"+newExpense.category+"','"+newExpense.note+"','"+newExpense.amount+"','"+newExpense.wallet+"','"+newExpense.spent_on+"');";
//			return 1;
			pst = con.prepareStatement("INSERT INTO public.\"Expense\" (username, category, note, amount, wallet, spent_on) VALUES (?, ?, ?, ?, ?, ?)");

			pst.setString(1, newExpense.username);
			pst.setString(2, newExpense.category);
			pst.setString(3, newExpense.note);
			pst.setBigDecimal(4, BigDecimal.valueOf(newExpense.amount)); // Adjust if necessary
			pst.setBigDecimal(5, BigDecimal.valueOf(newExpense.wallet));
			pst.setTimestamp(6, Timestamp.valueOf(newExpense.spent_on)); // Adjust if necessary

			int rowsAffected = pst.executeUpdate();
			return rowsAffected > 0 ? 1 : 0;
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
	public int compareMonthlySpending(String category, String username, String wallet) {
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		try {
			database dm=new database();
			con = dm.getConnect();
			// Query to get current month's spending
			String currentMonthQuery = "SELECT SUM(amount) AS current_month_spending "
					+ "FROM public.\"Expense\" "
					+ "WHERE category = ? AND wallet in (select id from public.\"Wallet\" where username = ? AND name=?) "
					+ "AND DATE_TRUNC('month', spent_on) = DATE_TRUNC('month', CURRENT_DATE)";

			// Query to get previous month's spending
			String previousMonthQuery = "SELECT SUM(amount) AS previous_month_spending "
					+ "FROM public.\"Expense\" "
					+ "WHERE category = ? AND wallet in (select id from public.\"Wallet\" where username = ? AND name=?) "
					+ "AND DATE_TRUNC('month', spent_on) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')";

			// Get current month's spending
			pst = con.prepareStatement(currentMonthQuery);
			pst.setString(1, category);
			pst.setString(2, username);
			pst.setString(3, wallet);
			rs = pst.executeQuery();
			BigDecimal currentMonthSpending = rs.next() && rs.getBigDecimal("current_month_spending") != null
					? rs.getBigDecimal("current_month_spending")
					: BigDecimal.ZERO;
			rs.close();
			pst.close();

			// Get previous month's spending
			pst = con.prepareStatement(previousMonthQuery);
			pst.setString(1, category);
			pst.setString(2, username);
			pst.setString(3, wallet);
			rs = pst.executeQuery();
			BigDecimal previousMonthSpending = rs.next() && rs.getBigDecimal("previous_month_spending") != null
					? rs.getBigDecimal("previous_month_spending")
					: BigDecimal.ZERO;

			// Calculate the difference
			BigDecimal difference = currentMonthSpending.subtract(previousMonthSpending);
			BigDecimal percentage = BigDecimal.ZERO;
			if (previousMonthSpending.compareTo(BigDecimal.ZERO) != 0) {
				percentage = difference.divide(previousMonthSpending, 4, RoundingMode.HALF_UP).multiply(new BigDecimal(100));
			}
			BigDecimal roundedPercentage = percentage.setScale(2, RoundingMode.HALF_UP);

			return roundedPercentage.intValue();

		} catch (SQLException exception) {
			exception.printStackTrace();
			return 0;
		} finally {
			// Close resources
			try {
				if (rs != null) rs.close();
				if (pst != null) pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	public void updateFau(){

		Connection con = null;
		PreparedStatement pst = null;
		try {
			database dm = new database();
			con = dm.getConnect();
			String query="UPDATE public.\"Expense\"\n" +
					"SET spent_on = '"+getToday()+"'::date + spent_on::time\n" +
					"WHERE spent_on::date = '2024-08-18'\n" +
					"AND username = 'john_doe';";
			Statement st = con.createStatement();
			st.executeUpdate(query);
		} catch (SQLException exception) {
			exception.printStackTrace();
		} finally {
			// Close resources
			try {
				if (pst != null) pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	public List<expense> getExpenses(String username){
		List<expense> result=new ArrayList<>();
		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			String querycheck="select * from public.\"Expense\" where username='"+username+"';";
			ResultSet rt=st.executeQuery(querycheck);
			while(rt.next())
			{
				expense w=new expense();
				w.id=rt.getInt("id");
				w.category=rt.getString("category");
				w.amount=rt.getInt("amount");
				w.note=rt.getString("note");//name
				w.spent_on=rt.getString("spent_on");
				w.wallet=rt.getInt("wallet");
				w.username=rt.getString("username");//
				result.add(w);
			}

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
			database dm=new database();
		    Connection con=dm.getConnect();
		    Statement st=con.createStatement();
		    String querycheck="SELECT sum(price) FROM main where username='"+ username +"'";
        	 ResultSet rt=st.executeQuery(querycheck);
        	 while(rt.next())
 		    {
 			  ans=rt.getString(1);
 			}
        	
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