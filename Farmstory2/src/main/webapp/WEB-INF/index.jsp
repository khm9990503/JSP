<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<c:if test="${sessUser==null}">
<script type="text/javascript">
$(function() {
	$(".arti").click(function(){
    	if(!confirm("로그인 하셔야 열람 가능합니다.\n회원이 아니시라면 회원가입 하시겠습니까?")){
    		return false;
    	}else{
    		location.href = "/Farmstory2/user/terms.do";
    		return false;
    	}
    });
});
</script>
</c:if>
   <main>
       <div class="slider">
           <div class="slider2">
               <div><img src="/Farmstory2/img/main_slide_img1.jpg" alt="sld"></div>
               <div><img src="/Farmstory2/img/main_slide_img2.jpg" alt="sld"></div>
               <div><img src="/Farmstory2/img/main_slide_img3.jpg" alt="sld"></div>
           </div>
           <img src="./img/main_slide_img_tit.png" alt="사람과 자연을">
           <div class="banner">
               <img src="/Farmstory2/img/main_banner_txt.png" alt="grand open">
               <img src="/Farmstory2/img/main_banner_tit.png" alt="오픈기념 30%">
               <img src="/Farmstory2/img/main_banner_img.png" alt="과일">
           </div>
       </div>
       <div class="quick">
           <a href="/Farmstory2/board/list.do?group=community&cate=today">
               <img src="/Farmstory2/img/main_banner_sub1_tit.png" alt="오늘의 식단">
           </a>
           <a href="/Farmstory2/board/list.do?group=community&cate=chef">
               <img src="/Farmstory2/img/main_banner_sub2_tit.png" alt="나도 요리사">
           </a>
       </div>
       <div class="latest">
           <div>
               <a href="#">
                   <img src="/Farmstory2/img/main_latest1_tit.png" alt="텃밭">
               </a>
               <img src="/Farmstory2/img/main_latest1_img.jpg" alt="img">
               <table>
               <c:forEach var="i" items="${latests}" begin="0" end="4">
                   <tr>
                       <td>></td>
                       <td>
                           <a href="/Farmstory2/board/view.do?group=story&cate=story2&pg=1&no=${i.no }" class="arti">${i.title }</a>
                       </td>
                       <td>${i.rdate }</td>
                   </tr>
               </c:forEach>
               </table>
           </div>
           <div>
               <a href="#">
                   <img src="/Farmstory2/img/main_latest2_tit.png" alt="텃밭">
               </a>
               <img src="/Farmstory2/img/main_latest2_img.jpg" alt="img">
               <table>
              <c:forEach var="i" items="${latests}" begin="5" end="9">
                   <tr>
                       <td>></td>
                       <td>
                           <a href="/Farmstory2/board/view.do?group=story&cate=story3&pg=1&no=${i.no }" class="arti">${i.title }</a>
                       </td>
                       <td>${i.rdate }</td>
                   </tr>
               </c:forEach>
               </table>
           </div>
           <div>
               <a href="#">
                   <img src="/Farmstory2/img/main_latest3_tit.png" alt="텃밭">
               </a>
               <img src="/Farmstory2/img/main_latest3_img.jpg" alt="img">
               <table>
               <c:forEach var="i" items="${latests}" begin="10" end="14">
                   <tr>
                       <td>></td>
                       <td>
                           <a href="/Farmstory2/board/view.do?group=story&cate=story&pg=1&no=${i.no }" class="arti">${i.title }</a>
                       </td>
                       <td>${i.rdate }</td>
                   </tr>
               </c:forEach>
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
                   <a href="/Farmstory2/board/list.do?group=community&cate=one" class="arti">
                       <img src="./img/main_sub2_cs_bt1.png" alt="1:1">
                   </a>
                   <a href="/Farmstory2/board/list.do?group=community&cate=question" class="arti">
                       <img src="./img/main_sub2_cs_bt2.png" alt="자주">
                   </a>
                   <a href="#">
                       <img src="./img/main_sub2_cs_bt3.png" alt="배송">
                   </a>
               </div>
           </div>
           <div>
               <img src="/Farmstory2/img/main_sub2_account_tit.png" class="tit" alt="계좌안내">
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
	                   	<c:forEach var="i" items="${latestN}">
	                   	<li><a href="/Farmstory2/board/view.do?group=community&cate=notice&pg=1&no=${i.no}" class="arti">* ${i.title}</a></li>
	                   	</c:forEach>
	                   </ul>
                   </div>
                   <div id="tabs-2">
                     	<ul class="txt">
	                   	<c:forEach var="i" items="${latestO}">
	                   	<li><a href="/Farmstory2/board/view.do?group=community&cate=one&pg=1&no=${i.no}" class="arti">* ${i.title}</a></li>
	                   	</c:forEach>
	                   </ul>
                   </div>
                   <div id="tabs-3">
                     	<ul class="txt">
	                   	<c:forEach var="i" items="${latestQ}">
	                   	<li><a href="/Farmstory2/board/view.do?group=community&cate=question&pg=1&no=${i.no}" class="arti">* ${i.title}</a></li>
	                   	</c:forEach>
	                   </ul>
                   </div>
                 </div>
           </div>
       </div>
   </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>