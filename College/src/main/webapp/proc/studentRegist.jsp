<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String stdno = request.getParameter("stdno");
	String stdname = request.getParameter("stdname");
	String stdhp= request.getParameter("stdhp");
	String stdyear = request.getParameter("stdyear");
	String stdaddress = request.getParameter("stdaddress");
	
	int result = 0;
	try{
		Connection conn = DBCP.getConnection();
		String sql = "insert into `student` values (?,?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, stdno);
		psmt.setString(2, stdname);
		psmt.setString(3, stdhp);
		psmt.setString(4, stdyear);
		psmt.setString(5, stdaddress);
		result = psmt.executeUpdate();
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// json 출력
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	String jsonData = json.toString();
	out.print(jsonData);
%>