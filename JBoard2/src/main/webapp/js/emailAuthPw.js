	let regUid = /^[a-z]+[a-z0-9]{3,19}$/g;
	
	let isUidOk		 = false;
	let preventDoubleClick	 	= false;
	let isEmailAuthCodeOk	 = false;
	let receivedCode = 0;
	
	$(function() {
		
		// 아이디 유효성 검증
		$('input[name=uid]').focusout(function() {
			let uid = $(this).val();
			if(!uid.match(regUid)){
				isUidOk=false;
				$('.resultUid').css('color','red').text('아이디는 영문 숫자 2~40자리 조합입니다.');
			}else{
				isUidOk=true;
				$('.resultUid').text('');
			}
		});
		// 이메일 인증코드 발송 클릭
		$('.btnAuth').click(function() {
			
			$(this).hide();
			
			let email = $('input[name=email]').val();
			
			if(email == ''){
				alert('이메일을 입력하세요.')
				return;
			}
			
			if(preventDoubleClick){
				return;
			}
			
			preventDoubleClick = true;
			
			$('.resultEmail').text('이메일 전송 중...');
			
			setTimeout(function() {
				
			$.ajax({
				url:'/JBoard2/user/emailAuth.do',
				method:'GET',
				data:{"email":email},
				dataType:'json',
				success:function(data){
					//console.log(data);
					if(data.status > 0){
						// 메일 전송 성공
						preventDoubleClick = true;
						$('.resultEmail').text('메일 확인 후 인증코드를 입력하세요.')
						$('.auth').show();
						receivedCode = data.code;
					}else {
						// 메일 전송 실패
						preventDoubleClick = false;
						alert("이메일 주소를 다시 확인해 주세요.")
					}
				}
			});
			},1000);
		});
		
		// 이메일 인증 코드 확인 버튼
		$('.btnConfirm').click(function() {
			let code = $('input[name=auth]').val();
			
			if(code == ''){
				alert('이메일 확인 후 인증코드를 입력하세요.');
				return;
			}else if(code == receivedCode){
				isEmailAuthCodeOk = true;
				$('input[name=email]').attr('readonly',true);
				$('.resultEmail').text('메일 인증 완료')
				$('.auth').hide();
			}else {
				isEmailAuthCodeOk = false;
				alert('인증코드가 틀립니다. \n 다시 확인 하십시오.');
			}
		});
		// 폼 전송이 시작될 때 실행되는 폼 이벤트(폼 전송 버튼을 클릭했을때)
		$('.findPw>form').submit(function(e) {
			
			// 폼 데이터 유효성 검증 Validation
			// 1.아이디 검증
			if(!isUidOk){
				alert('이름을 확인하십시오.');
				return false;
			}
			// 2.이메일 인증코드 검증
			if(!isEmailAuthCodeOk){
				alert('이메일 인증을 수행하십시오.');
				return false;
			}
			// 최종 전송
			return true;
		});
	});