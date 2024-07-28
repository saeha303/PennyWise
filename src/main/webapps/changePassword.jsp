<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.register.signin" %>
<%@ page import="org.expense.wallet" %>
<%@ page import="java.util.*" %>
<%
    String action=request.getParameter("action");
    if(action.equals("changePassword")){
        String user = (String)session.getAttribute("User");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String renewPassword = request.getParameter("renewPassword");
        signin signIn = new signin();
        int result = signIn.changePassword(user, currentPassword, newPassword, renewPassword);
        out.print(result);
    }else if(action.equals("validate")){
        String user=request.getParameter("username");
        String pass=request.getParameter("password");
        session.setAttribute("User",user);
        signin obj=new signin();
        int result=obj.validate(user,pass);
        session.setAttribute("name",obj.getname(user));
        out.print(result);
    }else if(action.equals("register")){
        String fn=request.getParameter("fn");
        String ln=request.getParameter("ln");
        String email=request.getParameter("email");
        String un=request.getParameter("un");
        String ps=request.getParameter("ps");
        String name=fn+" "+ln;
        session.setAttribute("User",un);
        session.setAttribute("name",fn+" "+ln);
        signin obj=new signin();
        int result=obj.store(fn,ln,email,un,ps);
        out.print(result);
    }else if(action.equals("addWallet")){
        String fn=request.getParameter("wallet_name");
        String ln=request.getParameter("group");
        String email=request.getParameter("group_description");
        String un=request.getParameter("group_number");
        String ps=request.getParameter("amount");
        String user=(String)session.getAttribute("User");
        wallet obj=new wallet();
        int result=obj.store(user,fn,ps,ln,email,un);
        out.print(result);
    }else if(action.equals("applyFilter")){
        String fn=request.getParameter("wallet");
        String ln=request.getParameter("group");
        System.out.println(fn);
        System.out.println(ln);
        String user=(String)session.getAttribute("User");
        wallet obj=new wallet();
        List<wallet> result=obj.getFilteredWallet("john_doe",fn,ln);
        out.print(result);
        
        
    }
%>
