<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>include 태그</title>
		<%--
			날짜 : 2022/10/07
			이름 : 구홍모
			내용 : JSP include 액션태그 실습하기
		
			include 태그
			 - 일반적으로 UI 모듈, 공통 전역 파일을 삽입할 때 사용하는 지시자
			 - 동적타임에 삽입(include 지시자는 정적타입에 삽입)
		 --%>
	</head>
	<body>
		<h3>include 액션태그</h3>
		
		<h4>include 지시자</h4>
		<%@ include file="/inc/_header.jsp" %>
		<%@ include file="/inc/_footer.jsp" %>
		<%@ include file="/inc/_config.jsp" %>
		
		<%
			out.print("num1 : "+num1+"<br>"); // num1은 _config에서 참조하기 위해 include 사용. 정적타입
			out.print("num2 : "+num2+"<br>"); 
			out.print("num3 : "+num3+"<br>"); 
		%>
		
		<h4>include 태그</h4> 
		<jsp:include page="/inc/_header.jsp"></jsp:include>
		<jsp:include page="/inc/_footer.jsp"></jsp:include>
		<jsp:include page="/inc/_config2.jsp"></jsp:include>
		
		<%
			// config2가 동적타입에 include되기 때문에 정적타입에 참조가 불가능
			// out.print("var1 : "+var1+"<br>"); 참조불가능 
		%>
		
		<h4>include 매서드</h4>
		<%
			pageContext.include("/inc/_header.jsp");
			pageContext.include("/inc/_footer.jsp");
		%>
	</body>
</html>