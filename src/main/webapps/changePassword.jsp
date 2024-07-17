<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.register.signin" %>

<%
    String user = "john_doe";
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String renewPassword = request.getParameter("renewPassword");

    signin signIn = new signin();
    int result = signIn.changePassword(user, currentPassword, newPassword, renewPassword);

    out.print(result);
%>
