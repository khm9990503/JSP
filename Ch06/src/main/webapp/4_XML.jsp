<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>4_XML</title>
		<!-- 
			날짜 : 2022/10/20
			이름 : 구홍모
			내용 : JSP JSON 실습
		-->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function () {
				$('button:eq(0)').click(function() {
					$.ajax({
						url:'./data/xml1.jsp',
						method:'GET',
						dataType:'XML',
						success:function(data){
							console.log(data);
							// xml 파싱
							let xml = $(data);
							$('p>span:eq(0)').text(xml.find('uid').text());
							$('p>span:eq(1)').text(xml.find('name').text());
							$('p>span:eq(2)').text(xml.find('hp').text());
							$('p>span:eq(3)').text(xml.find('age').text());
						}
					});
					
				});
				
				$('button:eq(1)').click(function() {
					$.ajax({
						url:'./data/xml2.jsp',
						method:'GET',
						dataType:'XML',
						success:function(data){
							console.log(data);
							// xml 파싱
							let users = $(data).find('user');
							
							users.each(function () {
								
								let tags  = "<tr>"; // ${$()} 인식 불가
									tags += "<td>"+$(this).find('uid').text()+"</td>";
									tags += "<td>"+$(this).find('name').text()+"</td>";
									tags += "<td>"+$(this).find('hp').text()+"</td>";
									tags += "<td>"+$(this).find('age').text()+"</td>";
									tags += "</tr>";
									
								$('table').append(tags);
								
							});
						}
					});
					
				});
				
			});
		</script>
	</head>
	<body>
		<h3>XML 실습</h3>
		<a href="./data/xml1.jsp">XML 출력</a>
		<a href="./data/xml2.jsp">XML 출력</a>
		
		<h4>AJAX 실습하기</h4>
		<button>데이터 요청하기</button>
		<p>
			아이디 : <span></span><br/>
			이름 : <span></span><br/>
			휴대폰 : <span></span><br/>
			나이 : <span></span><br/>
		</p>
		
		<button>데이터 요청하기</button>
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>나이</th>
			</tr>
		</table>
	</body>
</html>