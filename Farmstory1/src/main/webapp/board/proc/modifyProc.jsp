<%@page import="kr.co.Farmstory1.dao.ArticleDAO"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String pg = request.getParameter("pg");
	String no = request.getParameter("no");
	String title = request.getParameter("title");
	String content = request.getParameter("ir1");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	int result = dao.updateArticle(title, content, no);
	
	response.sendRedirect("../view.jsp?no="+no+"&pg="+pg+"&group="+group+"&cate="+cate);
%>