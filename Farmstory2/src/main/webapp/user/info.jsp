<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script>
	$(function() {
		$('input[name=pass]').keydown(function() {
			  if (event.keyCode === 13) {
			    event.preventDefault();
			  };
			});
		// 비밀번호 인증 클릭
		$('.btnNext').click(function() {
			
			let pass = $('input[name=pass]').val();
			let uid = $('input[name=uid]').val();
			
			if(pass == ''){
				alert('비밀번호를 입력하세요.')
				return false;
			}
			let jsonData = {
					"pass":pass,
					"uid":uid
			}
			$.ajax({
				url:'/Farmstory2/user/info.do',
				method:'post',
				data:jsonData,
				dataType:'json',
				success:function(data){
					if(data.result > 0){
						// 비번 인증 성공
						location.href="/Farmstory2/user/myInfo.do";
					}else {
						// 비번 인증 실패
						alert("비밀번호가 일치하지 않습니다.")
						return false;
					}
				}
			});
		});
	});
</script>
<main id="user">
    <section class="find findId">
        <form action="#" method="POST">
            <table border="0">
                <caption>비밀번화 확인</caption>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass" placeholder="비밀번호 입력"/></td>
                </tr>
            </table>                                        
	        <p>
	            회원님의 정보를 보호하기 위해 비밀번호를 다시 확인합니다.
	        </p>
	        <input type="hidden" name="uid" value="${sessUser.uid}"/>
	        <div>
	            <a href="/Farmstory2/list.do" class="btn btnCancel">취소</a>
	            <a href="#" class="btn btnNext">다음</a>
	        </div>
        </form>
    </section>
</main>
<jsp:include page="/WEB-INF/_footer.jsp"/>