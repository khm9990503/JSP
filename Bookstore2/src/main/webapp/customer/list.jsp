<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::list</title>
	</head>
	<body>
		<h3>고객목록</h3>
		
		<a href="../index.jsp">처음으로</a>
		<a href="/Bookstore2/customer/register.do">고객등록</a>
		
		<table border="1">
			<tr>
				<td>고객번호</td>
				<td>고객명</td>
				<td>주소</td>
				<td>휴대폰</td>
				<td>관리</td>
			</tr>
			<c:forEach var="customer" items="${requestScope.customers}">
			<tr>
				<td>${customer.cusid }</td>
				<td>${customer.name }</td>
				<td>${customer.address }</td>
				<td>${customer.phone }</td>
				<td>
					<a href="/Bookstore2/customer/modify.do?cusid=${customer.cusid }">수정</a>
					<a href="/Bookstore2/customer/delete.do?cusid=${customer.cusid }">삭제</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</body>
</html>