<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script>
	$(function() {
		let success = $('.suc').val();
		
		if(success == "100"){
			alert('얘기치 못한 에러로 비밀번호 수정이 불가합니다.\n나중에 다시 시도하십시오.');
		}
	});
</script>
<script src="/JBoard2/js/PwChange.js"></script>
<main id="user">
    <section class="find findPwChange">
        <form action="/JBoard2/user/findPwChange.do" method="post">
            <table border="0">
                <caption>비밀번호 변경</caption>                        
                <tr>
                    <td>아이디</td>
                    <td><input type="text" name="uid" value="${vo}" readonly></td>
                </tr>
                <tr>
                    <td>새 비밀번호</td>
                    <td>
                        <input type="password" name="pass1" placeholder="새 비밀번호 입력"/>
                    </td>
                </tr>
                <tr>
                    <td>새 비밀번호 확인</td>
                    <td>
                        <input type="password" name="pass2" placeholder="새 비밀번호 확인"/><span class="resultPass"></span>
                    </td>
                </tr>
            </table>                                        
        
        
	        <p>
	            비밀번호를 변경해 주세요.<br>
	            영문, 숫자, 특수문자를 사용하여 8자 이상 입력해 주세요.                    
	        </p>
			<input type="text" class="suc" value="${success}" style="display:none"/>
	        <div>
	            <a href="./login.do" class="btn btnCancel">취소</a>
	            <input type="submit" value="완료" class="btn btnNext"/>
	        </div>
        </form>
    </section>
</main>
<jsp:include page="/WEB-INF/_footer.jsp"/>