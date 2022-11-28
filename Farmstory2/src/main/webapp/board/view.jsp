<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>

        <main id="board" class="view">
            <h3>글보기</h3>
            <section>
                <form action="#">
                    <table>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="title" readonly></td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td>
                                <a href="#"></a>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td >
                                <div name="content"></div>
                            </td>
                        </tr>
                    </table>
                    <div class="send">
                    	
                        <a href="#" class="btn btnDelete" onclick="if(!confirm('삭제하시겠습니까?')){return false;}">삭제</a>
                        <a href="#" class="btn btnModify">수정</a>
                       
                        <a href="#" class="btn btnList">목록</a>
                    </div>
                </form>
            </section>
            <section class="commentList">
                <h3>댓글목록</h3>
                <article class="comment">
                    <span class="nick"></span>
                    <span class="date"></span>
                    <p class="comment"></p>
                    <div>
                        <a href="#" class="delete">삭제</a>
                        <a href="#" class="modify">수정</a>
                    </div>
                </article>
                <p class="empty">등록된 댓글이 없습니다.</p>
            </section>
            <section class="commentForm">
                <h3>댓글쓰기</h3>
                <form action="#" method="post">
                	<input type="hidden" name="pg" >
                	<input type="hidden" name="parent">
                	<input type="hidden" name="uid">
                    <textarea name="content" placeholder="댓글내용 입력"></textarea>
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
<jsp:include page="/WEB-INF/_footer.jsp"/>