<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	
	pageContext.include("./_"+group+".jsp");
%>
        <main id="board" class="view">
            <h3>글보기</h3>
            <section>
                <form action="#">
                    <table>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="title" value="제목입니다." readonly></td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td>
                                <a href="#">2020년 상반기 매출자료.xls</a>
                                <span>7</span>회 다운로드
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="content" readonly>내용 샘플입니다.</textarea>
                            </td>
                        </tr>
                    </table>
                    <div>
                        <a href="#" class="btn btnDelete">삭제</a>
                        <a href="./modify.jsp?group=<%=group %>&cate=<%=cate%>" class="btn btnModify">수정</a>
                        <a href="./list.jsp?group=<%=group %>&cate=<%=cate%>" class="btn btnList">목록</a>
                    </div>
                </form>
            </section>
            <section class="commentList">
                <h3>댓글목록</h3>
                <article class="comment">
                    <span class="nick">길동이</span>&nbsp;<span class="date">20-05-13</span>
                    <textarea name="comment" readonly>댓글 샘플입니다.</textarea>
                    <div>
                        <a href="#" class="delete">삭제</a>
                        <a href="#" class="modify">수정</a>
                    </div>
                </article>
                <p class="empty">등록된 댓글이 없습니다.</p>
            </section>
            <section class="commentForm">
                <h3>댓글쓰기</h3>
                <form action="#">
                    <textarea name="comment" placeholder="댓글내용 입력"></textarea>
                    <div>
                        <a href="#" class="btn btnCancel">취소</a>
                        <input type="submit" class="btn btnComplete" value="작성완료">
                    </div>
                </form>
            </section>
        </main>
            </article>
    </section>
</div>
 <%@ include file="../_footer.jsp" %>