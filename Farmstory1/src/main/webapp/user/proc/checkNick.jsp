<%@page import="kr.co.Farmstory1.dao.UserDAO"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
		request.setCharacterEncoding("utf-8");
		String nick = request.getParameter("nick");
	// 데이터베이스 확인
		int result = UserDAO.getInstance().selectCountNick(nick);
	
	// JSON 출력
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		
		String jsonData = json.toString();
		out.print(jsonData);
%>