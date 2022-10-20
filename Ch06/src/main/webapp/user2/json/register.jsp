<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DB"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("UTF-8");
	String uid	 = request.getParameter("uid");
	String name	 = request.getParameter("name");
	String hp	 = request.getParameter("hp");
	int age		 = Integer.parseInt(request.getParameter("age"));
	
	int result = 0;
	
	try{
		// 1단계
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2단계
		Connection conn = DB.getInstance().getConnection();
		// 3단계
		String sql = "INSERT INTO `user2` VALUES (?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1,uid);
		psmt.setString(2,name);
		psmt.setString(3,hp);
		psmt.setInt(4,age);
		
		// 4단계
		result = psmt.executeUpdate();
		// 5단계
		// 6단계
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	String jsonData = json.toString();
	
	out.print(jsonData);
%>