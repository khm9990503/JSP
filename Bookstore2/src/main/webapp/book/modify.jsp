<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>도서수정</title>
	</head>
	<body>
		<h3>도서수정</h3>
		
		<a href="../index.jsp">처음으로</a>
		<a href="/Bookstore2/book/list.do">목록으로</a>
		
		<form action="/Bookstore2/book/modify.do" method="post">
			<table border="1">
				<tr>
					<td>도서번호</td>
					<td> <input type="number" name="bookId" value="${book.bookId }"> </td>
				</tr>
				<tr>
					<td>도서명</td>
					<td> <input type="text" name="bookname" value="${book.bookname }"> </td>
				</tr>
				<tr>
					<td>출판사</td>
					<td> <input type="text" name="publisher" value="${book.publisher }"> </td>
				</tr>
				<tr>
					<td>가격</td>
					<td> <input type="number" name="price" value="${book.price }"> </td>
				</tr>
				<tr>
					<td colspan="2" align="right"> <input type="submit" value="수정"> </td>
				</tr>
			</table>
		</form>
	</body>
</html>