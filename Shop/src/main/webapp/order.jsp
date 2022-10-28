<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.Shop.bean.OrderBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.Shop.db.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<OrderBean> orders = null;
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		String sql = "SELECT a.`name`, b.*, c.`prodName` FROM `customer` AS a ";
				sql +=	"JOIN `order` AS b ";
				sql +=	"ON a.cusId = b.orderId ";
				sql +=	"JOIN `product` AS c ";
				sql +=	"ON b.orderProduct = c.prodNo";
		ResultSet rs = stmt.executeQuery(sql);
		orders = new ArrayList<>();
		while(rs.next()){
			OrderBean ob = new OrderBean();
			ob.setOrderNo(rs.getInt(2));
			ob.setOrderId(rs.getString(1));
			ob.setOrderProduct(rs.getString(7));
			ob.setOrderCount(rs.getInt(5));
			ob.setOrderdate(rs.getString(6));
			
			orders.add(ob);
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
		<title>Shop::order</title>
	</head>
	<body>
		<h3>주문목록</h3>
		
		<a href="/Shop/customer.jsp">고객목록</a>
		<a href="/Shop/order.jsp">주문목록</a>
		<a href="/Shop/product.jsp">상품목록</a>
		<table border="1">
			<tr>
				<th>주문번호</th>
				<th>주문자</th>
				<th>주문상품</th>
				<th>주문수량</th>
				<th>주문일</th>
			</tr>
			<%for(OrderBean ob : orders){ %>
			<tr>
				<td><%=ob.getOrderNo()%></td>
				<td><%=ob.getOrderId()%></td>
				<td><%=ob.getOrderProduct()%></td>
				<td><%=ob.getOrderCount()%></td>
				<td><%=ob.getOrderdate().substring(0,16)%></td>
			</tr>
			<%}%>
		</table>
	</body>
</html>