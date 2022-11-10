<%@page import="kr.co.college.bean.LectureBean"%>
<%@page import="java.util.ArrayList"%>
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
			LectureBean lb = new LectureBean();
			lb.setLecno(rs.getInt(1));
			lb.setLecname(rs.getString(2));
			
			lectures.add(lb);
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
		<title>register</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function() {
				$('.btnRE').click(function(){
					
					$('#reg').css("display","block");
					
				});
				
				$('.btnClose').click(function(){
					$('#reg').hide();
				});
				
				// 수강현황 목록
				$('.btnSearch').click(function() {
					
					$('.list').show();
					
					let regstdno = $("input[name=regstdno]").val();
					
					let jsonData = {
							"regstdno":regstdno
					};
					
					console.log('jsonData : '+jsonData);
					
					$.ajax({
						url:'./proc/registerList.jsp',
						type:'POST',
						data:jsonData,
						dataType:'json',
						success:function(data){
							console.log(data);
							for(let rb of data){
	                            let tags = "<tr>";
	                            	tags += "<td>"+rb.regstdno+"</td>";
	                            	tags += "<td>"+rb.stdname+"</td>";
	                            	tags += "<td>"+rb.lecname+"</td>";
	                            	tags += "<td>"+rb.reglecno+"</td>";
	                            	tags += "<td>"+rb.regmidscore+"</td>";
	                            	tags += "<td>"+rb.regfinalscore+"</td>";
	                            	tags += "<td>"+rb.regtotalscore+"</td>";
	                            	tags += "<td>"+rb.reggrade+"</td>";
	                            	tags += "</tr>";
	                            $('.list').append(tags);
	                        }
						}
					});
				});
				
				// 수강신청
				$('.btnAdd').click(function() {
					
					let stdno 		= $("input[name=stdno]").val();
					let stdname		= $("input[name=stdname]").val();
					let lec	 		= $("select[name=lec]").val();
					let lecname		= $("option[value="+lec+"]").text();
					
					
					let jsonData = {
							"stdno":stdno,
							"lec":lec
					};
					
					console.log('jsonData : '+jsonData);
					
					$.ajax({
						url:'./proc/registerProc.jsp',
						type:'POST',
						data:jsonData,
						dataType:'json',
						success:function(data){
							if(data.result == 1 ){
								alert('수강등록완료!');
								
		                            let tags = "<tr>";
		                            	tags += "<td>"+stdno+"</td>";
		                            	tags += "<td>"+stdname+"</td>";
		                            	tags += "<td>"+lecname+"</td>";
		                            	tags += "<td>"+lec+"</td>";
		                            	tags += "<td></td>";
		                            	tags += "<td></td>";
		                            	tags += "<td></td>";
		                            	tags += "<td></td>";
		                            	tags += "</tr>";
		                            $('.list').append(tags);
		                       
							}else{
								alert('수강등록실패!');
							}
						}
					});
				});
				
			});
		</script>
	</head>
	<body>
		<h3>수강관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		
		<h4>수강현황</h4>
		<input type="text" name="regstdno">
		<button class="btnSearch">검색</button>
		<button class="btnRE">수강신청</button>
		<table class="list" border="1" style="display:none">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>강좌명</th>
				<th>강좌코드</th>
				<th>중간시험</th>
				<th>기말시험</th>
				<th>총점</th>
				<th>등급</th>
			</tr>
		</table>
		
		<div id="reg" style="display:none">
		<h4>수강신청</h4>
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
				<th>신청강좌</th>
				<td>
					<select name="lec">
					<%for(LectureBean lb : lectures){ %>
						<option value="<%=lb.getLecno()%>"><%=lb.getLecname()%></option>
					<%} %>
					</select>
				</td>
			</tr>
			<tr> <td colspan="2" align="right"> <button class="btnAdd">신청</button> </td> </tr>
		</table>
		</div>
	</body>
</html>