<%@page import="bean.CustomerBean"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cusid = request.getParameter("cusid");
	CustomerBean customer = null;
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		String sql = "select * from `customer` where `cusid`='"+cusid+"'";
		ResultSet rs = stmt.executeQuery(sql);
		customer = new CustomerBean();
		if(rs.next()){
			customer.setCusid(rs.getInt(1));
			customer.setName(rs.getString(2));
			customer.setAddress(rs.getString(3));
			customer.setPhone(rs.getString(4));
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
		<title>customer::modify</title>
	</head>
	<body>
		<h3>고객수정</h3>
		
		<a href="../index.jsp">처음으로</a>
		<a href="./list.jsp">목록으로</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>고객번호</td>
					<td> <input type="number" name="cusid" value="<%=customer.getCusid() %>"> </td>
				</tr>
				<tr>
					<td>고객명</td>
					<td> <input type="text" name="name" value="<%=customer.getName()%>"> </td>
				</tr>
				<tr>
					<td>주소</td>
					<td> <input type="text" name="address" value="<%=customer.getAddress() %>"> </td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td> <input type="text" name="phone" value="<%=customer.getPhone() %>"> </td>
				</tr>
				<tr>
					<td colspan="2" align="right"> <input type="submit" value="수정"> </td>
				</tr>
			</table>
		</form>
	</body>
</html>