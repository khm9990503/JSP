<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
        <main id="board" class="write">
            <h3>글수정</h3>
            <section>
                <form action="#">
                    <table>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="title" placeholder="제목을 입력하세요."></td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="content"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>첨부</th>
                            <td>
                                <input type="file" name="file">
                            </td>
                        </tr>
                    </table>
                    <div>
                        <a href="./view.jsp" class="btnCancel">취소</a>
                        <input type="submit" class="btnComplete" value="수정완료">
                    </div>
                </form>
            </section>
        </main>
       <%@ include file="./_footer.jsp" %>