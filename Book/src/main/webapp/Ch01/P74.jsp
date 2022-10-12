<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" buffer="1kb" autoFlush="false"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>page 지시어 - buffer , autoflush 속성</title>
	</head>
	<body>
		<%	// 버퍼크기를 줄이고 버퍼가 가득 차면 에러가 나게
			for(int i=1; i<=100; i++){
				out.println("abcde12345");
			}
		%>
	</body>
</html>