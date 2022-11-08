<%@page import="bean.BookBean"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<BookBean> books = null;
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		String sql = "SELECT * FROM `book`";
		ResultSet rs = stmt.executeQuery(sql);
		books = new ArrayList<>();
		while(rs.next()){
			BookBean book = new BookBean();
			book.setBookId(rs.getInt(1));
			book.setBookname(rs.getString(2));
			book.setPublisher(rs.getString(3));
			book.setPrice(rs.getInt(4));
			
			books.add(book);
		}
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>list</title>
	</head>
	<body>
		<h3>도서목록</h3>
		
		<a href="../index.jsp">처음으로</a>
		<a href="./register.jsp">도서등록</a>
		
		<table border="1">
			<tr>
				<td>도서번호</td>
				<td>도서명</td>
				<td>출판사</td>
				<td>가격</td>
				<td>관리</td>
			</tr>
			<%for(BookBean book : books){%>
			<tr>
				<td><%=book.getBookId() %></td>
				<td><%=book.getBookname() %></td>
				<td><%=book.getPublisher() %></td>
				<td><%=book.getPrice() %></td>
				<td>
					<a href="./modify.jsp?bookId=<%= book.getBookId() %>">수정</a>
					<a href="./delete.jsp?bookId=<%= book.getBookId() %>">삭제</a>
				</td>
			</tr>
			<%} %>
		</table>
	</body>
</html>