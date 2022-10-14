<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//전송 데이터 수신
		request.setCharacterEncoding("UTF-8");
		String uid	 = request.getParameter("uid");
		
		
		try{
			Connection conn = DBCP.getConnection("dbcp_java1db");
			Statement stmt = conn.createStatement();
			String sql = "DELETE FROM `user5` WHERE `uid`='"+uid+"'";
			stmt.executeUpdate(sql);
			stmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		response.sendRedirect("./list.jsp");
%>