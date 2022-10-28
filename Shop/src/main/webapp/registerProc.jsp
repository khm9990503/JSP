<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.Shop.db.DBCP"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String orderProduct	 = request.getParameter("orderProduct");
	String stock		 = request.getParameter("stock");
	String orderId		 = request.getParameter("orderId");
	
	int result = 0;
	try{
		Connection conn = DBCP.getConnection();
		String  sql = "insert into `order` (`orderId`,`orderProduct`,`orderCount`,`orderdate`) ";
			 	sql += "values (?,?,?,now())";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, orderId);
		psmt.setString(2, orderProduct);
		psmt.setString(3, stock);
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