<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("UTF-8");
	int bookId	 = Integer.parseInt(request.getParameter("bookId")) ;
	String name	 = request.getParameter("name");
	String publisher	 = request.getParameter("publisher");
	int price		 = Integer.parseInt(request.getParameter("price"));
	
	
	
	try{
		
		Connection conn = DBCP.getConnection();
		// 3단계
		String sql = "INSERT INTO `book` VALUES (?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setInt(1,bookId);
		psmt.setString(2,name);
		psmt.setString(3,publisher);
		psmt.setInt(4,price);
		
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