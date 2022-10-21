<%@page import="config.JDBC"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//전송 데이터 수신
		request.setCharacterEncoding("UTF-8");
		int cusid	 = Integer.parseInt(request.getParameter("cusid")) ;
		String name	 = request.getParameter("name");
		String address	 = request.getParameter("address");
		int phone		 = Integer.parseInt(request.getParameter("phone"));
			
			
			try{
				
				Connection conn = JDBC.getInstance().getConnection();
				// 3단계
				String sql = "UPDATE `customer` SET `name`=?, `address`=?, `phone`=? ";
			   		   sql+= "WHERE `cusid`=?";
				PreparedStatement psmt = conn.prepareStatement(sql);
				psmt.setString(1,name);
				psmt.setString(2,address);
				psmt.setInt(3,phone);
				psmt.setInt(4,cusid);
				
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