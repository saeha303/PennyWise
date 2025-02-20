package org.expense;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.db.database;
import org.json.JSONObject;

public class budget {
	public int id, amount;
	public String username, startDate,endDate, wallet;
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
	public List<Integer> getBudget(String username,String wallet){
//		budget b=new budget();
//		String strMonthYear=getToday();
		List<Integer> result=new ArrayList<>();
		int id=0;
		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			wallet=correctApostrophe(wallet);
			String querycheck="select id,name from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"'";
			System.out.println(querycheck);
			ResultSet rt=st.executeQuery(querycheck);
			while(rt.next())
			{
				if(rt.getString(("name")).equals(wallet)){
					id=rt.getInt("id");
				}
			}
		}
		catch (SQLException exception) {
		}
//		return b;

		try {
		// 1. Send a request to the Python API
		String apiUrl = "http://localhost:5000/predict-budget";  // Replace with your actual API URL
		URL url = new URL(apiUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/json");

		// Add the JSON data to the request (username, wallet, month)
		conn.setDoOutput(true);
		String jsonInputString = "{"
				+ "\"username\": \""+username+"\","
				+ "\"wallet\": \""+id+"\","
				+ "\"month\": "+Calendar.getInstance().get(Calendar.MONTH)+1
				+ "}";
		conn.getOutputStream().write(jsonInputString.getBytes("UTF-8"));

		// 2. Read the response
		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String inputLine;
		StringBuilder content = new StringBuilder();
		while ((inputLine = in.readLine()) != null) {
			content.append(inputLine);
		}

		// Close the connections
		in.close();
		conn.disconnect();

		// 3. Parse the JSON response
		JSONObject jsonResponse = new JSONObject(content.toString());

		// 4. Extract the values and store them in a list
		for (String key : jsonResponse.keySet()) {

			double budgetValue = jsonResponse.getDouble(key);
			result.add((int) budgetValue);
		}

		// Print the extracted list
		System.out.println("Predicted Budgets: " + result);

	} catch (Exception e) {
		e.printStackTrace();
	}
		return result;
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
			String querycheck="select start_date,end_date from public.\"Budget\" where wallet='"+wallet+"' and '"+strMonthYear+"' between start_date and end_date";
			System.out.println(querycheck);
			ResultSet rt=st.executeQuery(querycheck);
			if(rt.next())
			{
				result.add(0,rt.getString("start_date")+" 00:00:00");
				result.add(1,rt.getString("end_date")+" 23:59:59");
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

	public List<Integer> getActualSpending(String username, String wallet){
//		budget b=new budget();
		List<Integer> result=new ArrayList<>();
		List<String> b_list=new budget().getStartEndDate(username,wallet);
		String strMonthYear=getToday();
		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			wallet=correctApostrophe(wallet);
			if(b_list!=null){
				String querycheck="select falls_under,sum(amount)/25 as amount from public.\"Expense\" join public.\"Category\" on public.\"Expense\".category=public.\"Category\".name where wallet in (select id from public.\"Wallet\" where username='"+username+"' and name='"+wallet+"') and spent_on between '"+b_list.get(0)+"' and '"+b_list.get(1)+"' group by falls_under  order by falls_under asc";
				System.out.println(querycheck);
				ResultSet rt=st.executeQuery(querycheck);
				while(rt.next())
				{
					result.add((int)rt.getInt("amount"));
				}

				System.out.println("Actual spending:"+result);
			}

		}
		catch (SQLException exception) {
		}
		return result;
	}
	public List<Integer> budgetPredictReal(String username, String wallet){
		List<Integer> result=new ArrayList<>();
		result.addAll(getBudget(username,wallet));
		result.addAll(getActualSpending(username,wallet));
		return result;
	}
	public List<budget> getBudgetList(String username){
//		budget b=new budget();
//		String strMonthYear=getToday();
		List<budget> result=new ArrayList<>();
		int id=0;
		try
		{
			database dm=new database();
			Connection con=dm.getConnect();
			Statement st=con.createStatement();
			String querycheck="select * from public.\"Budget\" where username='"+username+"'";
			System.out.println(querycheck);
			ResultSet rt=st.executeQuery(querycheck);
			while(rt.next())
			{
				budget b=new budget();
				b.id=rt.getInt("id");
				b.username=rt.getString("username");
				b.wallet=rt.getString("wallet");
				b.startDate=rt.getString("start_date");
				b.endDate=rt.getString("end_date");
				b.amount=rt.getInt("amount");
				result.add(b);
			}
		}
		catch (SQLException exception) {
		}
		return result;
	}

	public int store(budget newExpense) {
		Connection con = null;
		PreparedStatement pst = null;
		try {
			database dm = new database();
			con = dm.getConnect();
			newExpense.wallet=newExpense.wallet.replace("\\", "");
//			String query="SELECT * FROM public.\"Budget\" where username='"+username+"' and wallet='"+wallet+"' and strMonthYear+\"' between start_date and end_date);";
//			return 1;
			pst = con.prepareStatement("INSERT INTO public.\"Budget\" (username, wallet, start_date, end_date, amount) VALUES (?, ?, ?, ?, ?)");

			pst.setString(1, newExpense.username);
			pst.setString(2, newExpense.wallet);
			pst.setDate(3, Date.valueOf(newExpense.startDate));
			pst.setDate(4, Date.valueOf(newExpense.endDate)); // Adjust if necessary
			pst.setBigDecimal(5, BigDecimal.valueOf(newExpense.amount));

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
}