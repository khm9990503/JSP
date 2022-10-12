<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cookieConfirm</title>
	</head>
	<body>
		<h3>cookie 확인하기</h3>
		<%
			// 클라이언트에서 서버로 전송되는 쿠키확인
			Cookie[] cookies = request.getCookies();
			
			for(Cookie cookie : cookies){
		%>
			<P>
				쿠키명 : <%= cookie.getName() %><br/>
				쿠키값 : <%= cookie.getValue() %><br/>
			</P>
		<%		
			}
		%>
		
		<a href="../1_Cookies.jsp"></a>
	</body>
</html>