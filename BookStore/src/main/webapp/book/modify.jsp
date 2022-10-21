<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.JDBC"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.BookBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bookId = request.getParameter("bookId");
	BookBean book = null;
	try{
		Connection conn = JDBC.getInstance().getConnection();
		Statement stmt = conn.createStatement();
		String sql = "select * from `book` where `bookId`='"+bookId+"'";
		ResultSet rs = stmt.executeQuery(sql);
		book = new BookBean();
		if(rs.next()){
			book.setBookId(rs.getInt(1));
			book.setBookname(rs.getString(2));
			book.setPublisher(rs.getString(3));
			book.setPrice(rs.getInt(4));
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
		<title>도서수정</title>
	</head>
	<body>
		<h3>도서수정</h3>
		
		<a href="../index.jsp">처음으로</a>
		<a href="./list.jsp">목록으로</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>도서번호</td>
					<td> <input type="number" name="bookId" value="<%=book.getBookId() %>"> </td>
				</tr>
				<tr>
					<td>도서명</td>
					<td> <input type="text" name="name" value="<%=book.getBookname() %>"> </td>
				</tr>
				<tr>
					<td>출판사</td>
					<td> <input type="text" name="publisher" value="<%=book.getPublisher() %>"> </td>
				</tr>
				<tr>
					<td>가격</td>
					<td> <input type="number" name="price" value="<%=book.getPrice() %>"> </td>
				</tr>
				<tr>
					<td colspan="2" align="right"> <input type="submit" value="수정"> </td>
				</tr>
			</table>
		</form>
	</body>
</html>