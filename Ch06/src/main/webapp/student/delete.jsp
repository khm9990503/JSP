<%@page import="config.DB"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String stdno = request.getParameter("stdno");
	
	try{
	Connection conn = DB.getInstance().getConnection();
	Statement stmt = conn.createStatement();
	String sql = "DELETE FROM `student` WHERE `stdno`='"+stdno+"'";
	stmt.executeUpdate(sql);
	stmt.close();
	conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>