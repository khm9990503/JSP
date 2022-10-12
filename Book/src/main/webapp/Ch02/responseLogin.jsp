<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내장 객체 - response</title>
	</head>
	<body>
		<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		if(id.equalsIgnoreCase("must") && pw.equalsIgnoreCase("1234")){
			response.sendRedirect("responseWelcome.jsp");
		}
		else {
			request.getRequestDispatcher("responseMain.jsp?loginErr=1").forward(request, response);
		}
		%>
	</body>
</html>