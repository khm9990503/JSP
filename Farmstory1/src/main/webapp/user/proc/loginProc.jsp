<%@page import="kr.co.Farmstory1.bean.UserBean"%>
<%@page import="kr.co.Farmstory1.dao.UserDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	String uid = request.getParameter("uid");
	String pass = request.getParameter("pass");
	
	UserBean ub = UserDAO.getInstance().selectUser(uid, pass);
	
	if(ub!=null){
		//회원 O
		session.setAttribute("sessUser", ub);
		response.sendRedirect("/Farmstory1/index.jsp");
	}else{
		//회원 X
		response.sendRedirect("/Farmstory1/user/login.jsp?success=100");
	}
%>