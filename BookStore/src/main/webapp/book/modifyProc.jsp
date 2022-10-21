<%@page import="config.JDBC"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//전송 데이터 수신
		request.setCharacterEncoding("UTF-8");
		int bookId			 = Integer.parseInt(request.getParameter("bookId")) ;
		String bookname	 		 = request.getParameter("name");
		String publisher	 = request.getParameter("publisher");
		int price			 = Integer.parseInt(request.getParameter("price"));
		
			
			
			try{
				
				Connection conn = JDBC.getInstance().getConnection();
				// 3단계
				String sql = "UPDATE `book` SET `bookname`=?, `publisher`=?, `price`=? ";
			   		   sql+= "WHERE `bookId`=?";
				PreparedStatement psmt = conn.prepareStatement(sql);
				psmt.setString(1,bookname);
				psmt.setString(2,publisher);
				psmt.setInt(3,price);
				psmt.setInt(4,bookId);
				
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