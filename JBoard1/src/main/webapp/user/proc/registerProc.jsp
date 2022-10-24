<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("UTF-8");
	String uid	 = request.getParameter("uid");
	String pass	 = request.getParameter("pass1");
	String name	 = request.getParameter("name");
	String nick	 = request.getParameter("nick");
	String email = request.getParameter("email");
	String hp = request.getParameter("hp");
	String zip = request.getParameter("zip");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");	
	String regip = request.getRemoteAddr();
	
	try{
	Connection conn = DBCP.getConnection();
	String sql = "INSERT INTO `board_user` SET `uid`=?, `pass`=SHA2(?,256), `name`=?, `nick`=?, `email`=?, `hp`=?, `rdate`=NOW(), `regip`=?, `zip`=?, `addr1`=?, `addr2`=?";
	PreparedStatement psmt = conn.prepareStatement(sql);
	psmt.setString(1, uid);
	psmt.setString(2, pass);
	psmt.setString(3, name);
	psmt.setString(4, nick);
	psmt.setString(5, email);
	psmt.setString(6, hp);
	psmt.setString(7, regip);
	psmt.setString(8, zip);
	psmt.setString(9, addr1);
	psmt.setString(10, addr2);
	
	psmt.executeUpdate();
	
	psmt.close();
	conn.close();
	
	}catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("../login.jsp");
%>