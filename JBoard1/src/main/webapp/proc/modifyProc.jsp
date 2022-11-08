<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String pg = request.getParameter("pg");
	String no = request.getParameter("no");
	String title = request.getParameter("title");
	String content = request.getParameter("ir1");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	int result = dao.updateArticle(title, content, no);
	
	response.sendRedirect("../view.jsp?no="+no+"&pg="+pg);
%>