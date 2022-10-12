<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" errorPage="IsErrorPage.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>page 지시어 - errorPage, isErrorPage 속성</title>
	</head>
	<body>
		<%
		try{
		int myAge = Integer.parseInt(request.getParameter("age"))+10;
		out.print("10년 후 당신의 나이는 "+myAge+"입니다.");
		}
		catch(Exception e){
			out.print("예외 발생 : 매개변수 age 가 null입니다.");
		}
		%>
	</body>
</html>