<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>
<c:choose>
<c:when test="${sessUser==null}">
<script type="text/javascript">
	$(function() {
		//비회원 전용 클릭이벤트
	    $(".btnWrite").click(function(){
        	if(!confirm("로그인 하셔야 작성 가능합니다.\n회원이 아니시라면 회원가입 하시겠습니까?")){
        		return false;
        	}else{
        		location.href == "/Farmstory2/user/terms.do";
        		return false;
        	}
        	
	    });
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
</c:when>
<c:when test="${cate.equals('notice')||cate.equals('question')||cate.equals('event')}">
<script type="text/javascript">
	$(function() {
		//관리자 전용 글쓰기버튼 클릭이벤트
	    $(".btnWrite").click(function(){
	    	let grade = $("input[name=grade]").val();
	    	if(grade!=1){
	        	alert("관리자만 작성가능합니다.");
	        	return false;
	        }
	    });
	});
</script>
</c:when>
</c:choose>
        <main id="board">
            <section class="list">
	            <form action="/Farmstory2/board/list.do" method="get">
	            	<input type="hidden" name="grade" value="${sessUser.grade}">
	            	<input type="hidden" name="group" value="${group}">
	            	<input type="hidden" name="cate" value="${cate}">
	            	<select name="search_type" style="height: 26px">
	            		<option value="nick">글쓴이</option>
	            		<option value="title">제목</option>
	            		<option value="both">글쓴이+제목</option>
	            	</select>
		            <input type="text" name="search" placeholder="제목 키워드, 글쓴이 검색">
		            <input type="submit" value="검색">
	       		</form>
                <table border="0">
                	<caption>글목록</caption>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>글쓴이</th>
                        <th>날짜</th>
                        <th>조회</th>
                    </tr>
                    <c:choose>
                    <c:when test="${articles.size() >= 1}">
                    <c:forEach var="article" items="${articles}" varStatus="i">
		                <tr>
		                    <td>${pageStartNum-i.index}</td>
		                    <td><a href="/Farmstory2/board/view.do?no=${article.no}&pg=${currentPage}&search=${search}&group=${group}&cate=${cate}" class="arti">${article.title}</a>
		                        &nbsp;[${article.comment}]
		                    </td>
		                    <td>${article.nick}</td>
		                    <td>${article.rdate.substring(2,10)}</td>
		                    <td>${article.hit}</td>
		                </tr>
           			</c:forEach>
           			</c:when>
           			<c:otherwise>
	           			<tr>
	           				<td colspan="5" style="text-align: center">게시물이 존재하지 않습니다.</td>
	           			</tr>
           			</c:otherwise>
           			</c:choose>
                </table>
            
	            <div class="page">
		            <c:if test="${pageGroupStart gt 1}">
		            <a href="/Farmstory2/board/list.do?pg=${pageGroupStart-1}&search=${search}&group=${group}&cate=${cate}" class="prev">이전</a>
		            </c:if>
		            <c:forEach var="i" begin="${pageGroupStart }" end="${pageGroupEnd }">
		            <a href="/Farmstory2/board/list.do?pg=${i}&search=${search}&group=${group}&cate=${cate}" class="num ${i==currentPage?'current':'off'}">${i}</a>
		            </c:forEach>
		            <c:if test="${pageGroupEnd lt lastPageNum}">
		            <a href="/Farmstory2/board/list.do?pg=${pageGroupStart+1}&search=${search}&group=${group}&cate=${cate}" class="next">다음</a>
		            </c:if>
	        	</div>
            	<a href="./write.do?group=${group}&cate=${cate}" class="btn btnWrite">글쓰기</a>
            </section>
        </main>
                </article>
    </section>
</div>
<jsp:include page="/WEB-INF/_footer.jsp"/>