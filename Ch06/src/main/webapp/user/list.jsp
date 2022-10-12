<%@page import="java.util.List"%>
<%@page import="bean.UserBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
List<UserBean> users = null; // for문에서 참조할 수 있기 위해 try에서 빼서 선언
try{
	String host = "jdbc:mysql://127.0.0.1:3306/java1db";
	String user = "root";
	String pass = "1234";
	// 1단계
	Class.forName("com.mysql.cj.jdbc.Driver");
	// 2단계
	Connection conn = DriverManager.getConnection(host, user, pass);
	// 3단계
	Statement stmt = conn.createStatement();
	// 4단계
	String sql = "SELECT * FROM `user3`";
	ResultSet rs = stmt.executeQuery(sql);
	// 5단계
	users = new ArrayList<>(); // null인 users를 ArrayList로 초기화
	
	while(rs.next()){
		
		UserBean ub = new UserBean();
		ub.setUid(rs.getString(1));
		ub.setName(rs.getString(2));
		ub.setHp(rs.getString(3));
		ub.setAge(rs.getInt(4));
		
		users.add(ub); // list에 넣기
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
		<title>user::list</title>
	</head>
	<body>
		<h3>user 목록</h3>
		<a href="./register.jsp">user 등록하기</a>
		<table border="1">
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>휴대폰</td>
				<td>나이</td>
				<td>관리</td>
			</tr>
			<% for(UserBean ub : users){ %>
			<tr>
				<td><%=ub.getUid() %></td>
				<td><%=ub.getName() %></td>
				<td><%=ub.getHp() %></td>
				<td><%=ub.getAge() %></td>
				<td>
					<a href="./modify.jsp?uid=<%=ub.getUid()%>">수정</a>
					<a href="./delete.jsp?uid=<%=ub.getUid()%>">삭제</a>
				</td>
			</tr>
			<%} %>
		</table>
	</body>
</html>