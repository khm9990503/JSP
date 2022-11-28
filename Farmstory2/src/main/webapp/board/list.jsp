<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>
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
                    <tr>
                        <td><a href="#"></a>
                            &nbsp;
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </section>
            <div class="page">
            	
            </div>
            <a href="#" class="btnwrite">글쓰기</a>
        </main>
                </article>
    </section>
</div>
<jsp:include page="/WEB-INF/_footer.jsp"/>