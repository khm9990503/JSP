<%@page import="kr.co.Farmstory1.dao.ArticleDAO"%>
<%@page import="com.google.gson.JsonObject"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String parent = request.getParameter("parent");
	
	int result = ArticleDAO.getInstance().deleteComment(no, parent);
	
	// json 출력
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	json.addProperty("no", no);
	
	out.print(json.toString());
%>