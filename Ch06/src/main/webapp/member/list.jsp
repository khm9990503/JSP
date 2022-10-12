<%@page import="bean.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
List<MemberBean> members = null; // for문에서 참조할 수 있기 위해 try에서 빼서 선언
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
	String sql = "SELECT * FROM `member`";
	ResultSet rs = stmt.executeQuery(sql);
	// 5단계
	members = new ArrayList<>(); // null인 users를 ArrayList로 초기화
	
	while(rs.next()){
		
		MemberBean mb = new MemberBean();
		mb.setUid(rs.getString(1));
		mb.setName(rs.getString(2));
		mb.setHp(rs.getString(3));
		mb.setPos(rs.getString(4));
		mb.setDep(rs.getInt(5));
		mb.setRdate(rs.getString(6));
		
		members.add(mb); // list에 넣기
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
		<title>member::list</title>
	</head>
	<body>
		<h3>member 목록</h3>
		<a href="./register.jsp">member 등록하기</a>
		<table border="1">
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>휴대폰</td>
				<td>직급</td>
				<td>부서</td>
				<td>등록일</td>
				<td>관리</td>
			</tr>
			<% for(MemberBean mb : members){ %>
			<tr>
				<td><%=mb.getUid() %></td>
				<td><%=mb.getName() %></td>
				<td><%=mb.getHp() %></td>
				<td><%=mb.getPos() %></td>
				<td><%=mb.getDep() %></td>
				<td><%=mb.getRdate() %></td>
				<td>
					<a href="./modify.jsp?uid=<%=mb.getUid()%>">수정</a>
					<a href="./delete.jsp?uid=<%=mb.getUid()%>">삭제</a>
				</td>
			</tr>
			<%} %>
		</table>
	</body>
</html>