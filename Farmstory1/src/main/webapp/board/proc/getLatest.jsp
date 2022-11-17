<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.Farmstory1.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.Farmstory1.dao.ArticleDAO"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String cate = request.getParameter("cate");

	List<ArticleBean> latestn = ArticleDAO.getInstance().selectLatestN(cate);
	
	Gson gson = new Gson();
	String jsonData = gson.toJson(latestn);
	
	out.print(jsonData);
%>