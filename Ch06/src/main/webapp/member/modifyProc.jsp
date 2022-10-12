<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//전송 데이터 수신
		request.setCharacterEncoding("UTF-8");
		String uid	 = request.getParameter("uid");
		String name	 = request.getParameter("name");
		String hp	 = request.getParameter("hp");
		String pos	= request.getParameter("pos");
		String rdate= request.getParameter("rdate");
		int dep		 = Integer.parseInt(request.getParameter("dep"));
		
		
			// 데이터베이스 처리
			String host = "jdbc:mysql://127.0.0.1:3306/java1db";
			String user = "root";
			String pass = "1234";
			
			try{
				// 1단계
				Class.forName("com.mysql.cj.jdbc.Driver");
				// 2단계
				Connection conn = DriverManager.getConnection(host, user, pass);
				// 3단계
				String sql = "UPDATE `member` SET `name`=?, `hp`=?, `pos`=?, `dep`=?, `rdate`=? ";
			   		   sql+= "WHERE `uid`=?";
				PreparedStatement psmt = conn.prepareStatement(sql);
				psmt.setString(1,name);
				psmt.setString(2,hp);
				psmt.setString(3,pos);
				psmt.setInt(4,dep);
				psmt.setString(5,rdate);
				psmt.setString(6,uid);
				
				// 4단계
				psmt.executeUpdate();
				// 5단계
				// 6단계
				psmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}	   
		   
	response.sendRedirect("./list.jsp");
%>