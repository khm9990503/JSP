<%@page import="java.util.ArrayList"%>
<%@page import="bean.StudentBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.DB"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
List<StudentBean> students = null;
	try{
		Connection conn = DB.getInstance().getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `student`");
		
		students = new ArrayList<>();
		while(rs.next()){
	
		StudentBean sb = new StudentBean();
		sb.setStdno(rs.getString(1));
		sb.setStdname(rs.getString(2));
		sb.setStdhp(rs.getString(3));
		sb.setStdyear(rs.getInt(4));
		sb.setStdaddress(rs.getString(5));
		students.add(sb); // list에 넣기
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
		<title>student::list</title>
	</head>
	<body>
		<h3>student 목록</h3>
		<a href="./register.jsp">student 등록</a>
		<table border="1">
			<tr>
				<td>학번</td>
				<td>이름</td>
				<td>휴대폰</td>
				<td>학년</td>
				<td>주소</td>
				<td>관리</td>
			</tr>
			<% for(StudentBean sb : students){ %>
			<tr>
				<td><%=sb.getStdno() %></td>
				<td><%=sb.getStdname() %></td>
				<td><%=sb.getStdhp() %></td>
				<td><%=sb.getStdyear() %></td>
				<td><%=sb.getStdaddress() %></td>
				<td>
					<a href="./modify.jsp?stdno=<%=sb.getStdno()%>">수정</a>
					<a href="./delete.jsp?stdno=<%=sb.getStdno()%>" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
				</td>
			</tr>
			<%} %>
		</table>
	</body>
</html>