<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script src="/Farmstory2/js/validation.js"></script>
<script src="/Farmstory2/js/postcode.js"></script>
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<main id="user">
    <section class="register">
        <form action="/Farmstory2/user/register.do" method="post">
            <table border="1">
                <caption>사이트 이용정보 입력</caption>
                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" name="uid" placeholder="아이디 입력"/>
                        <button type="button" id="btnUidCheck"><img src="/Farmstory2/img/chk_id.gif" alt="중복확인"/></button>
                        <span class="uidResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass1" placeholder="비밀번호 입력"/></td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td><input type="password" name="pass2" placeholder="비밀번호 입력 확인"/><span class="resultPass"></span></td>
                </tr>
            </table>
            <table border="1">
                <caption>개인정보 입력</caption>
                <tr>
                    <td>이름</td>
                    <td>
                        <input type="text" name="name" placeholder="이름 입력"/><span class="resultName"></span>                      
                    </td>
                </tr>
                <tr>
                    <td>별명</td>
                    <td>
                        <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                        <input type="text" name="nick" placeholder="별명 입력"/>
                        <button type="button" id="btnNickCheck"><img src="/Farmstory2/img/chk_id.gif" alt="중복확인"/></button>
                        <span class="nickResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        <input type="email" name="email" placeholder="이메일 입력"/>
                        <button type="button" id="btnEmail"><img src="/Farmstory2/img/chk_auth.gif" alt="인증번호 받기"/></button>
                        <span class="resultEmail"></span>
                        <div class="auth">
                            <input type="text" name="auth" placeholder="인증번호 입력"/>
                            <button type="button" id="btnEmailConfirm"><img src="/Farmstory2/img/chk_confirm.gif" alt="확인"/></button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>휴대폰</td>
                    <td><input type="text" name="hp" placeholder="휴대폰 입력"/><span class="resultHp"></span></td>
                </tr>
                <tr>
	                <td>주소</td>
	                <td>
	                    <div>
	                        <input type="text" name="zip" id="zip" placeholder="우편번호" readonly>
	                        <button type="button" onclick="postcode()">
	                        <img src="/Farmstory2/img/chk_post.gif" alt="우편번호 찾기">
	                        </button>
	                    </div>
	                    <div>
	                        <input type="text" name="addr1" id="addr1" placeholder="주소를 검색하세요" readonly>
	                    </div>
	                    <div>
	                        <input type="text" name="addr2" id="addr2" placeholder="상세주소를 입력하세요">
	                    </div>
                </td>
            </tr>
            </table>
            <div>
                <a href="./login.do" class="btn btnCancel">취소</a>
                <input type="submit" value="회원가입" class="btn btnRegister"/>
            </div>
        </form>
    </section>
</main>
<jsp:include page="/WEB-INF/_footer.jsp"/>