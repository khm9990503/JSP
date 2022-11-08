<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.college.bean.LectureBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<LectureBean> lectures = null;
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		String sql = "select * from `lecture`";
		ResultSet rs = stmt.executeQuery(sql);
		lectures = new ArrayList<>();
		while(rs.next()){
			LectureBean lecture = new LectureBean();
			lecture.setLecno(rs.getInt(1));
			lecture.setLecname(rs.getString(2));
			lecture.setLeccredit(rs.getInt(3));
			lecture.setLectime(rs.getInt(4));
			lecture.setLecclass(rs.getString(5));
			
			lectures.add(lecture);
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
		<title>lecture</title>
	</head>
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
					
					let lecno 		= $("input[name=lecno]").val();
					let lecname		 = $("input[name=lecname]").val();
					let leccredit	 = $("input[name=leccredit]").val();
					let lectime		 = $("input[name=lectime]").val();
					let lecclass	= $("input[name=lecclass]").val();
					
					let jsonData = {
							"lecno":lecno,
							"lecname":lecname,
							"leccredit":leccredit,
							"lectime":lectime,
							"lecclass":lecclass
					};
					
					console.log('jsonData : '+jsonData);
					
					$.ajax({
						url:'./proc/lectureRegist.jsp',
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
	<body>
		<h3>강좌관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		
		<h4>강좌현황</h4>
		<button class="btnrg">등록</button>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>강좌명</th>
				<th>학점</th>
				<th>시간</th>
				<th>강의장소</th>
			</tr>
			<%for(LectureBean lecture : lectures){ %>
			<tr>
				<td><%=lecture.getLecno() %></td>
				<td><%=lecture.getLecname() %></td>
				<td><%=lecture.getLeccredit() %></td>
				<td><%=lecture.getLectime() %></td>
				<td><%=lecture.getLecclass() %></td>
			</tr>
			<%} %>
		</table>
		
		<div id="reg" style="display:none">
		<h4>강좌등록</h4>
		<button class="btnClose">닫기</button>
		<table border="1">
			<tr>
				<th>번호</th>
				<td>
					<input type="text" name="lecno">
				</td>
			</tr>
			<tr>
				<th>강좌명</th>
				<td>
					<input type="text" name="lecname">
				</td>
			</tr>
			<tr>
				<th>학점</th>
				<td>
					<input type="text" name="leccredit">
				</td>
			</tr>
			<tr>
				<th>시간</th>
				<td>
					<input type="text" name="lectime">
				</td>
			</tr>
			<tr>
				<th>강의장</th>
				<td>
					<input type="text" name="lecclass">
				</td>
			</tr>
			<tr> <td colspan="2" align="right"> <button class="btnAdd">추가</button> </td> </tr>
		</table>
		</div>
	</body>
</html>