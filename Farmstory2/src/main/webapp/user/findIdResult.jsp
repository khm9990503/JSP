<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<main id="user">
    <section class="find findIdResult">
        <form action="#">
            <table border="0">
                <caption>아이디 찾기 결과</caption>
                <tr>
                    <td>이름</td>
                    <td>${forId.name}</td>
                </tr>
                <tr>
                    <td>아이디</td>
                    <td>${forId.uid }</td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>${forId.email }</td>
                </tr>
                <tr>
                    <td>가입일</td>
                    <td>${forId.rdate }</td>
                </tr>
            </table>                                        
        </form>
        
        <p>
            고객님의 정보와 일치하는 아이디 입니다.
        </p>

        <div>
            <a href="./login.do" class="btn btnCancel">로그인</a>
            <a href="./findPw.do" class="btn btnNext">비밀번호 찾기</a>
        </div>
    </section>
</main>
<jsp:include page="/WEB-INF/_footer.jsp"/>