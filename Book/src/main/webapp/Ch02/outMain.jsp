<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내장객체 - out</title>
	</head>
	<body>
		<%
			//버퍼 내용 삭제
			out.print("출력되지 않는 텍스트");
			out.clearBuffer();
			
			out.print("<h2>out 내장객체</h2>");
			
			//버퍼 크기 정보 확인
			out.print("출력 버퍼 크기 : "+out.getBufferSize()+"<br>");
			out.print("남은 버퍼 크기 : "+out.getRemaining()+"<br>");
			
			out.flush();
			out.print("flush 후 버퍼 크기 : "+out.getRemaining()+"<br>");
			
			//다양한 타입 값 출력
			out.print(1+"<br>");
			out.print(false+"<br>");
			out.print('가'+"<br>");
		%>
	</body>
</html>