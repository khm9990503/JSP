<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script>
$(function() {
	// 공지사항 최신글 가져오기
	$.get('/Farmstory2/index.do?cate=notice',function(data){
		$('#tabs-1  .loading').remove();
		
		for(let latestn of data){
			//console.log(latestn.title);
			let url = "/Farmstory2/board/view.do?group=community&cate=notice&pg=1&no="+latestn.no;
			$('#tabs-1 .txt').append("<li><a href='"+url+"'>* "+latestn.title+"</a></li>");
		}
	});
	// 고객문의 최신글 가져오기
	$.get('/Farmstory2/index.do?cate=one',function(data){
		$('#tabs-2  .loading').remove();
		
		for(let latestn of data){
			//console.log(latestn.title);
			let url = "/Farmstory2/board/view.do?group=community&cate=one&pg=1&no="+latestn.no;
			$('#tabs-2 .txt').append("<li><a href='"+url+"'>* "+latestn.title+"</a></li>");
		}
	});
	// 자주묻는질문 가져오기
	$.get('/Farmstory2/index.do?cate=question',function(data){
		$('#tabs-3  .loading').remove();
		
		for(let latestn of data){
			//console.log(latestn.title);
			let url = "/Farmstory2/board/view.do?group=community&cate=question&pg=1&no="+latestn.no;
			$('#tabs-3 .txt').append("<li><a href='"+url+"'>* "+latestn.title+"</a></li>");
		}
	});
});
</script>
   <main>
       <div class="slider">
           <div class="slider2">
               <div><img src="./img/main_slide_img1.jpg" alt="sld"></div>
               <div><img src="./img/main_slide_img2.jpg" alt="sld"></div>
               <div><img src="./img/main_slide_img3.jpg" alt="sld"></div>
           </div>
           <img src="./img/main_slide_img_tit.png" alt="사람과 자연을">
           <div class="banner">
               <img src="./img/main_banner_txt.png" alt="grand open">
               <img src="./img/main_banner_tit.png" alt="오픈기념 30%">
               <img src="./img/main_banner_img.png" alt="과일">
           </div>
       </div>
       <div class="quick">
           <a href="/Farmstory1/board/list.jsp?group=community&cate=today">
               <img src="./img/main_banner_sub1_tit.png" alt="오늘의 식단">
           </a>
           <a href="/Farmstory1/board/list.jsp?group=community&cate=chef">
               <img src="./img/main_banner_sub2_tit.png" alt="나도 요리사">
           </a>
       </div>
       <div class="latest">
           <div>
               <a href="#">
                   <img src="./img/main_latest1_tit.png" alt="텃밭">
               </a>
               <img src="./img/main_latest1_img.jpg" alt="img">
               <table>
               <c:forEach var="lt" items="${latests}" begin="1" end="5">
                   <tr>
                       <td>></td>
                       <td>
                           <a href="/Farmstory1/board/view.jsp?group=story&cate=story2&pg=1&no=<%=lt.getNo()%>"><%=lt.getTitle()%></a>
                       </td>
                       <td><%=lt.getRdate()%></td>
                   </tr>
               </c:forEach>
               </table>
           </div>
           <div>
               <a href="#">
                   <img src="./img/main_latest2_tit.png" alt="텃밭">
               </a>
               <img src="./img/main_latest2_img.jpg" alt="img">
               <table>
               <%
               for(int i=5;i<10;i++){ 
               	ArticleBean lt = latests.get(i);
               %>
                   <tr>
                       <td>></td>
                       <td>
                           <a href="/Farmstory1/board/view.jsp?group=story&cate=story3&pg=1&no=<%=lt.getNo()%>"><%=lt.getTitle()%></a>
                       </td>
                       <td><%=lt.getRdate()%></td>
                   </tr>
               <%} %>
               </table>
           </div>
           <div>
               <a href="#">
                   <img src="./img/main_latest3_tit.png" alt="텃밭">
               </a>
               <img src="./img/main_latest3_img.jpg" alt="img">
               <table>
               <%
               for(int i=10;i<15;i++){ 
               	ArticleBean lt = latests.get(i);
               %>
                   <tr>
                       <td>></td>
                       <td>
                           <a href="/Farmstory1/board/view.jsp?group=story&cate=story&pg=1&no=<%=lt.getNo()%>"><%=lt.getTitle()%></a>
                       </td>
                       <td><%=lt.getRdate()%></td>
                   </tr>
               <%} %>
               </table>
           </div>
       </div>
       <div class="info">
           <div>
               <img src="./img/main_sub2_cs_tit.png" class="tit" alt="1">
               <div class="tel">
                   <img src="./img/main_sub2_cs_img.png" alt="2">
                   <img src="./img/main_sub2_cs_txt.png" alt="3">
                   <p class="time">
                       평일: AM 09:00 ~ PM 06:00<br>
                       점심: PM 12:00 ~ PM 01:00<br>
                       토, 일요일, 공휴일 휴무
                   </p>
               </div>
               <div class="btns">
                   <a href="/Farmstory1/board/list.jsp?group=community&cate=one">
                       <img src="./img/main_sub2_cs_bt1.png" alt="1:1">
                   </a>
                   <a href="/Farmstory1/board/list.jsp?group=community&cate=question">
                       <img src="./img/main_sub2_cs_bt2.png" alt="자주">
                   </a>
                   <a href="#">
                       <img src="./img/main_sub2_cs_bt3.png" alt="배송">
                   </a>
               </div>
           </div>
           <div>
               <img src="./img/main_sub2_account_tit.png" class="tit" alt="계좌안내">
               <p class="account">
                   기업은행 123-456789-01-01-012<br>
                   국민은행 01-1234-56789<br>
                   우리은행 123-456789-01-01-012<br>
                   하나은행 123-456789-01-01<br>
                   예 금 주 (주)팜스토리
               </p>
           </div>
           <div>
               <div id="tabs">
                   <ul>
                     <li><a href="#tabs-1">공지사항</a></li>
                     <li><a href="#tabs-2">1:1 고객문의</a></li>
                     <li><a href="#tabs-3">자주묻는질문</a></li>
                   </ul>
                   <div id="tabs-1">
	                   <ul class="txt">
	                   	<img src="./img/loading.gif" class="loading">
	                   </ul>
                   </div>
                   <div id="tabs-2">
                     	<ul class="txt">
	                   	<img src="./img/loading.gif" class="loading">
	                   </ul>
                   </div>
                   <div id="tabs-3">
                     	<ul class="txt">
	                   	<img src="./img/loading.gif" class="loading">
	                   </ul>
                   </div>
                 </div>
           </div>
       </div>
   </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>