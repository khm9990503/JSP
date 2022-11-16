<%@page import="kr.co.Farmstory1.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.Farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	
	pageContext.include("./_"+group+".jsp");
	
	//리스트 작업
	request.setCharacterEncoding("UTF-8");
	String pg = request.getParameter("pg");
	
	int start = 0;
	int total = 0;
	int lastPageNum = 0;
	int currentPage = 1;
	int currentPageGroup = 1;
	int pageGroupStart = 0;
	int pageGroupEnd = 0;
	int pageStartNum = 0;
	
	if(pg!=null){
		currentPage = Integer.parseInt(pg);
	}
	
	start = (currentPage - 1) * 10;
	currentPageGroup = (int)Math.ceil(currentPage / 10.0);
	pageGroupStart = (currentPageGroup - 1) * 10 + 1;
	pageGroupEnd = currentPageGroup * 10;
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	//전체 게시물 갯수
	total = dao.selectCountTotal();
	
	//마지막 페이지 번호
	if(total % 10 == 0){
		lastPageNum = total / 10;
	}else{
		lastPageNum = total / 10 + 1;
	}
	if(pageGroupEnd > lastPageNum){
		pageGroupEnd = lastPageNum;
	}
	
	pageStartNum = total - start;
	
	List<ArticleBean> articles = dao.selectArticles(start);
%>

        <main id="board" class="list">
            <h3>글목록</h3>
            <section>
                <table border="0">
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>글쓴이</th>
                        <th>날짜</th>
                        <th>조회</th>
                    </tr>
                    <%for(ArticleBean AB : articles){ %>
                    <tr>
                        <td><%=pageStartNum-- %></td>
                        <td><a href="/Farmstory1/board/view.jsp?no=<%=AB.getNo()%>&pg=<%=currentPage%>&group=<%=group%>&cate=<%=cate%>"><%=AB.getTitle() %></a>
                            &nbsp;[<%=AB.getComment() %>]
                        </td>
                        <td><%=AB.getNick() %></td>
                        <td><%=AB.getRdate().substring(2,10) %></td>
                        <td><%=AB.getHit() %></td>
                    </tr>
                    <%} %>
                </table>
            </section>
            <div class="page">
            	<%if(pageGroupStart>1){ %>
                <a href="/Farmstory1/board/list.jsp?pg=<%=pageGroupStart-1 %>&group=<%=group%>&cate=<%=cate%>" class="prev">이전</a>
                <%} %>
                <% for(int num=pageGroupStart; num<=pageGroupEnd; num++){ %>
                <a href="/Farmstory1/board/list.jsp?pg=<%=num %>&group=<%=group%>&cate=<%=cate%>" class="num <%=(num==currentPage)?"current":"off"%>"><%=num %></a>
                <%} %>
                <%if(pageGroupEnd<lastPageNum){ %>
                <a href="/Farmstory1/board/list.jsp?pg=<%=pageGroupEnd+1 %>&group=<%=group%>&cate=<%=cate%>" class="next">다음</a>
                <%} %>
            </div>
            <a href="/Farmstory1/board/write.jsp?group=<%=group%>&cate=<%=cate%>" class="btnwrite">글쓰기</a>
        </main>
                </article>
    </section>
</div>
<%@ include file="../_footer.jsp" %>