<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script src="/Farmstory2/js/updateVali.js"></script>
<script src="/Farmstory2/js/postcode.js"></script>
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	
	// 비번 수정 버튼 클릭 시
	$('.btnUpdatePw').click(function() {
		let pass1 = $('input[name=pass1]').val();
		let pass2 = $('input[name=pass2]').val();
		if(pass1 == '' & pass2== ''){
			alert("수정할 비밀번호를 입력해주세요.");
			return;
		}
		
		let pass = $("input[name=pass2]").val();
		let uid = $("input[name=uid]").val();
		let jsonData = {
				"pass":pass,
				"uid":uid
		}
		if(!isPassOk){
			alert("비밀번호를 다시 확인하십시오.");
			return;
		}else{
			$.ajax({
				url:'/Farmstory2/user/myInfo.do',
				method:'post',
				data:jsonData,
				dataType:'json',
				success:function(data){
					if(data.result > 0){
						// 비번 수정 성공
						alert("비밀번호 수정 완료.");
					}else {
						// 비번 수정 실패
						alert("나중에 다시 시도하세요.");
						return;
					}
					}
				});
		}
		
	});
	
	// 회원 탈퇴 버튼 클릭 시
	$(".btnDrop").click(function() {
		let uid = $("input[name=uid]").val();
		let jsonData = {
				"uid":uid
		}
		$.ajax({
			url:'/Farmstory2/user/dropUser.do',
			method:'get',
			data:jsonData,
			dataType:'json',
			success:function(data){
				if(data.result > 0){
					// 회원 탈퇴 성공
					location.href="/Farmstory2/user/login.do?success=501";
				}else {
					// 회원 탈퇴 실패
					alert("나중에 다시 시도하십시오.")
					return false;
				}
			}
		});
	});
});
</script>
<main id="user">
    <section class="register">
        <form action="/Farmstory2/user/myInfo.do" method="post">
            <table border="1">
                <caption>회원 정보 설정</caption>
                <tr>
                    <td>아이디</td>
                    <td>
                        ${sessUser.uid }<input type="hidden" name="uid" value="${sessUser.uid}"/>
                    </td>
                    
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass1" placeholder="비밀번호 입력"/><span class="resultPass"></span></td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td><input type="password" name="pass2" placeholder="비밀번호 입력 확인"/>
                    <button type="button" class="btnUpdatePw" style="padding:6px; background:#2e658a; color:#fff;">비밀번호 수정</button></td>
                </tr>
                <tr>
                	<td>회원가입일</td>
                	<td>${sessUser.rdate}</td>
                </tr>
            </table>
            <table border="1">
                <caption>개인정보 수정</caption>
                <tr>
                    <td>이름</td>
                    <td>
                        <input type="text" name="name" value="${sessUser.name }"/><span class="resultName"></span>                      
                    </td>
                </tr>
                <tr>
                    <td>별명</td>
                    <td>
                        <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                        <input type="text" name="nick" value="${sessUser.nick}"/>
                        <button type="button" id="btnNickCheck"><img src="/Farmstory2/img/chk_id.gif" alt="중복확인"/></button>
                        <span class="nickResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        <input type="email" name="email" value="${sessUser.email }"/>
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
                    <td><input type="text" name="hp" value="${sessUser.hp}"/><span class="resultHp"></span></td>
                </tr>
                <tr>
	                <td>주소</td>
	                <td>
	                    <div>
	                        <input type="text" name="zip" id="zip" value="${sessUser.zip }" readonly>
	                        <button type="button" onclick="postcode()">
	                        <img src="/Farmstory2/img/chk_post.gif" alt="우편번호 찾기">
	                        </button>
	                    </div>
	                    <div>
	                        <input type="text" name="addr1" id="addr1" value="${sessUser.addr1 }" readonly>
	                    </div>
	                    <div>
	                        <input type="text" name="addr2" id="addr2" value="${sessUser.addr2 }">
	                    </div>
                </td>
            </tr>
            <tr>
            	<td>회원탈퇴</td>
            	<td>
            		<button type="button" class="btnDrop" style="padding:6px; background:#ed2f2f; color:#fff;">회원탈퇴</button>
            	</td>
            </tr>
            </table>
            <div>
                <a href="/Farmstory2/user/login.do" class="btn btnCancel">취소</a>
                <input type="submit" value="회원수정" class="btn btnUpdate"/>
            </div>
        </form>
    </section>
</main>
<jsp:include page="/WEB-INF/_footer.jsp"/>