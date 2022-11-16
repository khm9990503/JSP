<%@page import="kr.co.Farmstory1.dao.ArticleDAO"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	//글삭제
	dao.deleteArticle(no);
	
	//DB 파일 삭제
	String fileName = dao.deleteFile(no);
	
	//실제 파일 삭제(디렉토리)
	if(fileName != null){
		
		String path = application.getRealPath("/board/file");
		
		File file = new File(path, fileName);
		
		if(file.exists()){
			file.delete();
		}
		
	}
	
	response.sendRedirect("../list.jsp?pg="+pg+"&group="+group+"&cate="+cate);
	
%>