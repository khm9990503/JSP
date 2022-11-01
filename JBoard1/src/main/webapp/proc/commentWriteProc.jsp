<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String pg		 = request.getParameter("pg");
	String parent	 = request.getParameter("parent");
	String uid		 = request.getParameter("uid");
	String content	 = request.getParameter("content");
	String regip	 = request.getRemoteAddr();
	
	ArticleBean comment = new ArticleBean();
	comment.setParent(parent); // int parent가 아닌 String parent
	comment.setUid(uid);
	comment.setContent(content);
	comment.setRegip(regip);
	
	ArticleBean article = ArticleDAO.getInstance().insertComment(comment);
	//response.sendRedirect("../view.jsp?no="+parent+"&pg="+pg);
	
	//json 출력
	JsonObject json = new JsonObject();
	json.addProperty("result", 1);
	json.addProperty("no", article.getNo());
	json.addProperty("parent", article.getParent());
	json.addProperty("nick", article.getNick());
	json.addProperty("date", article.getRdate());
	json.addProperty("content", article.getContent());
	String jsonData = json.toString();
	out.print(jsonData);
%>