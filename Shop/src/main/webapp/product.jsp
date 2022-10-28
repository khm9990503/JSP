<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.Shop.bean.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.Shop.db.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<ProductBean> products = null;
	try{
	Connection conn = DBCP.getConnection();
	Statement stmt = conn.createStatement();
	String sql = "select * from `product`";
	ResultSet rs = stmt.executeQuery(sql);
	products = new ArrayList<>();
	while(rs.next()){
		ProductBean pb = new ProductBean();
		pb.setProdNo(rs.getInt(1));
		pb.setProdName(rs.getString(2));
		pb.setStock(rs.getInt(3));
		pb.setPrice(rs.getInt(4));
		pb.setCompany(rs.getString(5));
		
		products.add(pb);
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
		<title>Shop::product</title>
		<style>
			#order {
				display : none;
			}
		</style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function() {
				$('.btnOrder').click(function(){
					
					let orderProduct = $(this).val();
					
					//$('#order').css("display","block");
					$('#order').show().find('input[name=orderProduct]').val(orderProduct);
				});
				$('.btnClose').click(function(){
					$('#order').hide();
				});
				
				// 최종 주문하기 버튼
				$('input[type=submit]').click(function() {
					
					let orderProduct = $("input[name=orderProduct]").val();
					let stock		 = $("input[name=stock]").val();
					let orderId		 = $("input[name=orderId]").val();
					
					let jsonData = {
							"orderProduct":orderProduct,
							"stock":stock,
							"orderId":orderId
					};
					
					console.log('jsonData : '+jsonData);
					
					$.ajax({
						url:'./registerProc.jsp',
						type:'POST',
						data:jsonData,
						dataType:'json',
						success:function(data){
							if(data.result == 1 ){
								alert('주문완료!');
							}else{
								alert('주문실패!');
							}
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<h3>상품목록</h3>
		
		<a href="/Shop/customer.jsp">고객목록</a>
		<a href="/Shop/order.jsp">주문목록</a>
		<a href="/Shop/product.jsp">상품목록</a>
		<table border="1">
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>재고량</th>
				<th>가격</th>
				<th>제조사</th>
				<th>주문</th>
			</tr>
			<%for(ProductBean pb : products){%>
			<tr>
				<td><%=pb.getProdNo()%></td>
				<td><%=pb.getProdName()%></td>
				<td><%=pb.getStock()%></td>
				<td><%=pb.getPrice()%></td>
				<td><%=pb.getCompany()%></td>
				<td>
					<button class="btnOrder" value="<%=pb.getProdNo()%>">주문</button>
				</td>
			</tr>
			<%}%>
		</table>
		
		<div id="order">
			<h4>주문하기</h4>
				<table border="1">
					<tr>
						<th>상품번호</th>
						<td>
							<input type="text" name="orderProduct" readonly/>
						</td>
					</tr>
					<tr>
						<th>수량</th>
						<td>
							<input type="text" name="stock" />
						</td>
					</tr>
					<tr>
						<th>주문자</th>
						<td>
							<input type="text" name="orderId" />
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<input type="submit" value="주문하기"/>
						</td>
					</tr>
				</table>
				<button class="btnClose">닫기</button>
		</div>
	</body>
</html>