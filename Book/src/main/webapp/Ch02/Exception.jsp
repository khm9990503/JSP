<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내장객체 - exception</title>
	</head>
	<body>
		<%
		int status = response.getStatus();
		
		//에러코드에 따라 적절한 메세지 출력
		if(status==404){
			out.print("404 에러가 발생");
			out.print("<br>파일 경로를 확인해주세요.");
		}else if(status==405){
			out.print("405 에러가 발생");
			out.print("<br>요청 방식을 확인해주세요.");
		}else if(status==500){
			out.print("500 에러가 발생");
			out.print("<br>소스코드에 오류가 없는지 확인해주세요.");
		}else
		%>
	</body>
</html>