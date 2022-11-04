<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleBean article = ArticleDAO.getInstance().selectArticle(no);
	
%>
<%@ include file="./_header.jsp" %>
        <main id="board" class="write">
            <h3>글수정</h3>
            <section>
                <form action="/JBoard1/proc/modifyProc.jsp" method="post">
                	<input type="hidden" name="no" value="<%=no%>">
                	<input type="hidden" name="pg" value="<%=pg%>">
                    <table>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="title" placeholder="제목을 입력하세요." value="<%=article.getTitle()%>"></td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="content"><%=article.getContent()%></textarea>
                            </td>
                        </tr>
                    </table>
                    <div>
                        <a href="/JBoard1/view.jsp" class="btnCancel">취소</a>
                        <input type="submit" class="btnComplete" value="수정완료">
                    </div>
                </form>
            </section>
        </main>
       <%@ include file="./_footer.jsp" %>