<%@page import="config.DB"%>
<%@page import="bean.StudentBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String stdno = request.getParameter("stdno");
	StudentBean sb = null;
	try{
		Connection conn = DB.getInstance().getConnection();
		// 3단계
		Statement stmt = conn.createStatement();
		// 4단계
		ResultSet rs = stmt.executeQuery("SELECT * FROM `student` WHERE `stdno`='"+stdno+"'");
		// 5단계
		// 없는 경우를 생각해서 if문
		
		if(rs.next()){
			sb = new StudentBean();
			sb.setStdno(rs.getString(1));
			sb.setStdname(rs.getString(2));
			sb.setStdhp(rs.getString(3));
			sb.setStdyear(rs.getInt(4));
			sb.setStdaddress(rs.getString(5));
		}
		// 6단계
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
		<title>student::modify</title>
	</head>
	<body>
		<h3>student 수정하기</h3>
		
		<a href="./list.jsp">student 목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td> <input type="text" name="stdno" readonly value="<%=sb.getStdno()%>"/> </td>
				</tr>
				<tr>
					<td>이름</td>
					<td> <input type="text" name="stdname" value="<%=sb.getStdname()%>"/> </td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td> <input type="text" name="stdhp" value="<%=sb.getStdhp()%>"/> </td>
				</tr>
				<tr>
					<td>학년</td>
					<td> <input type="number" name="stdyear" value="<%=sb.getStdyear()%>"/> </td>
				</tr>
				<tr>
					<td>주소</td>
					<td> <input type="text" name="stdaddress" value="<%=sb.getStdaddress()%>"/> </td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="수정하기">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>