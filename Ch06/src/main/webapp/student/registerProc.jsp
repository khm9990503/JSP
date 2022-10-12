<%@page import="config.DB"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("UTF-8");
	String stdno	 = request.getParameter("stdno");
	String stdname	 = request.getParameter("stdname");
	String stdhp	 = request.getParameter("stdhp");
	int stdyear		 = Integer.parseInt(request.getParameter("stdyear"));
	String stdaddress= request.getParameter("stdaddress");
	
	
	try{
		Connection conn = DB.getInstance().getConnection();
		// 3단계
		String sql = "INSERT INTO `student` VALUES (?,?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1,stdno);
		psmt.setString(2,stdname);
		psmt.setString(3,stdhp);
		psmt.setInt(4,stdyear);
		psmt.setString(5,stdaddress);
		
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
	
	response.sendRedirect("./register.jsp");
%>