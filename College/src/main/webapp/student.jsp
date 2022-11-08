<%@page import="kr.co.college.bean.StudentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<StudentBean> students = null;
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		String sql = "select * from `student`";
		ResultSet rs = stmt.executeQuery(sql);
		students = new ArrayList<>();
		while(rs.next()){
			StudentBean student = new StudentBean();
			student.setStdno(rs.getString(1));
			student.setStdname(rs.getString(2));
			student.setStdhp(rs.getString(3));
			student.setStdyear(rs.getInt(4));
			student.setStdaddress(rs.getString(5));
			
			students.add(student);
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
		<title>student</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function() {
				$('.btnrg').click(function(){
					
					
					
					$('#reg').css("display","block");
					
				});
				
				$('.btnClose').click(function(){
					$('#reg').hide();
				});
				
				// 강좌등록 버튼
				$('.btnAdd').click(function() {
					
					let stdno 		= $("input[name=stdno]").val();
					let stdname		 = $("input[name=stdname]").val();
					let stdhp	 = $("input[name=stdhp]").val();
					let stdyear		 = $("input[name=stdyear]").val();
					let stdaddress	= $("input[name=stdaddress]").val();
					
					let jsonData = {
							"stdno":stdno,
							"stdname":stdname,
							"stdhp":stdhp,
							"stdyear":stdyear,
							"stdaddress":stdaddress
					};
					
					console.log('jsonData : '+jsonData);
					
					$.ajax({
						url:'./proc/studentRegist.jsp',
						type:'POST',
						data:jsonData,
						dataType:'json',
						success:function(data){
							if(data.result == 1 ){
								alert('등록완료!');
							}else{
								alert('등록실패!');
							}
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<h3>학생관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		
		<h4>학생현황</h4>
		<button class="btnrg">등록</button>
		<table border="1">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>학년</th>
				<th>주소</th>
			</tr>
			<%for(StudentBean student : students){ %>
			<tr>
				<td><%=student.getStdno() %></td>
				<td><%=student.getStdname() %></td>
				<td><%=student.getStdhp() %></td>
				<td><%=student.getStdyear() %></td>
				<td><%=student.getStdaddress() %></td>
			</tr>
			<%} %>
		</table>
		
		<div id="reg" style="display:none">
		<h4>학생등록</h4>
		<button class="btnClose">닫기</button>
		<table border="1">
			<tr>
				<th>학번</th>
				<td>
					<input type="text" name="stdno">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="stdname">
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>
					<input type="text" name="stdhp">
				</td>
			</tr>
			<tr>
				<th>학년</th>
				<td>
					<select name="stdyear">
						<option value="1">1학년</option>
						<option value="2">2학년</option>
						<option value="3">3학년</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="stdaddress">
				</td>
			</tr>
			<tr> <td colspan="2" align="right"> <button class="btnAdd">추가</button> </td> </tr>
		</table>
		</div>
	</body>
</html>