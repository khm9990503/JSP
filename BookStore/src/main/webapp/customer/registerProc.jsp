<%@page import="config.JDBC"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("UTF-8");
	int cusid	 = Integer.parseInt(request.getParameter("cusid")) ;
	String name	 = request.getParameter("name");
	String address	= request.getParameter("address");
	String phone	= request.getParameter("phone");
	
	
	
	try{
		
		Connection conn = JDBC.getInstance().getConnection();
		// 3단계
		String sql = "INSERT INTO `customer` VALUES (?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setInt(1,cusid);
		psmt.setString(2,name);
		psmt.setString(3,address);
		psmt.setString(4,phone);
		
		// 4단계
		psmt.executeUpdate();
		// 5단계
		// 6단계
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// redirect
	
	response.sendRedirect("./list.jsp");
%>