<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<script src="/JBoard1/js/validation.js"></script>
<script src="/JBoard1/js/postcode.js"></script>
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <main id="user" class="register">
            <form action="/JBoard1/user/proc/registerProc.jsp" method="post">
            <table border="1">
                <caption>사이트 이용정보 입력</caption>
                    <tr>
                        <td>아이디</td>
                        <td><input type="text" name="uid" placeholder="아이디 입력">
                            <button type="button" id="btnUidCheck">
                                <img src="/JBoard1/img/chk_id.gif" alt="중복확인">
                            </button>  <span class="resultUid"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>비밀번호</td>
                        <td><input type="password" name="pass1" placeholder="비밀번호 입력"></td>
                    </tr>
                    <tr>
                        <td>비밀번호 확인</td>
                        <td><input type="password" name="pass2" placeholder="비밀번호 확인 입력">
                        	<span class="resultPass"></span>
                        </td>
                    </tr>
            </table>
            <table border="1">
                <caption>개인정보 입력</caption>
                    <tr>
                        <td>이름</td>
                        <td><input type="text" name="name" placeholder="이름 입력"><span class="resultName"></span></td>
                    </tr>
                    <tr>
                        <td>별명</td>
                        <td><p>공백없이 한글, 영문, 숫자만 입력가능</p><br/>
                            <input type="text" name="nick" placeholder="별명 입력">
                            <button type="button" id="btnNickCheck">
                                <img src="/JBoard1/img/chk_id.gif" alt="중복확인">
                            </button> <span class="resultNick"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>E-Mail</td>
                        <td><input type="email" name="email" placeholder="이메일 입력"><span class="resultEmail"></span></td>
                    </tr>
                    <tr>
                        <td>휴대폰</td>
                        <td><input type="text" name="hp" placeholder="-포함 13자리 입력" pattern=".{13,13}"><span class="resultHp"></span></td>
                    </tr>
                    <tr>
                        <td>주소</td>
                        <td>
                            <div>
                                <input type="text" name="zip" id="zip" placeholder="우편번호" readonly>
                                <button type="button" onclick="postcode()">
                                <img src="/JBoard1/img/chk_post.gif" alt="우편번호 찾기">
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
                <a href="/JBoard1/user/login.jsp" class="btnCancel">취소</a>
                <input type="submit" class="btnJoin" value="회원가입">
            </div>
        	</form>
        </main>
<%@ include file="./_footer.jsp" %>