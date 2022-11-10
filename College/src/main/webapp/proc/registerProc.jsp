<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String regstdno = request.getParameter("stdno");
	String reglecno = request.getParameter("lec");
	int result = 0;
	try{
		Connection conn = DBCP.getConnection();
		String sql = "insert into `register` (`regstdno`,`reglecno`) values (?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, regstdno);
		psmt.setString(2, reglecno);
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