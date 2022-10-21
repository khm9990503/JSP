<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//전송 데이터 수신
		request.setCharacterEncoding("UTF-8");
		int cusid	 = Integer.parseInt(request.getParameter("cusid"));
		
		
		try{
			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement();
			String sql = "DELETE FROM `customer` WHERE `cusid`='"+cusid+"'";
			stmt.executeUpdate(sql);
			stmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		response.sendRedirect("./list.jsp");
%>