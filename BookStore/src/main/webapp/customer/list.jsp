<%@page import="bean.CustomerBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.JDBC"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>

<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<CustomerBean> customers = null;
	try{
		Connection conn = JDBC.getInstance().getConnection();
		Statement stmt = conn.createStatement();
		String sql = "select * from `customer`";
		ResultSet rs = stmt.executeQuery(sql);
		customers = new ArrayList<>();
		while(rs.next()){
			CustomerBean customer = new CustomerBean();
			customer.setCusid(rs.getInt(1));
			customer.setName(rs.getString(2));
			customer.setAddress(rs.getString(3));
			customer.setPhone(rs.getString(4));
			
			customers.add(customer);
		}
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
		<title>customer::list</title>
	</head>
	<body>
		<h3>고객목록</h3>
		
		<a href="../index.jsp">처음으로</a>
		<a href="./register.jsp">고객등록</a>
		
		<table border="1">
			<tr>
				<td>고객번호</td>
				<td>고객명</td>
				<td>주소</td>
				<td>휴대폰</td>
				<td>관리</td>
			</tr>
			<%for(CustomerBean customer : customers){%>
			<tr>
				<td><%=customer.getCusid() %></td>
				<td><%=customer.getName() %></td>
				<td><%=customer.getAddress() %></td>
				<td><%=customer.getPhone() %></td>
				<td>
					<a href="./modify.jsp?cusid=<%= customer.getCusid() %>">수정</a>
					<a href="./delete.jsp?cusid=<%= customer.getCusid() %>">삭제</a>
				</td>
			</tr>
			<%} %>
		</table>
	</body>
</html>