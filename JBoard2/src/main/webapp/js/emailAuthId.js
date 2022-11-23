	let regName = /^[가-힣]{2,4}$/;
	
	let isNameOk	 = false;
	let preventDoubleClick	 	= false;
	let isEmailAuthCodeOk	 = false;
	let receivedCode = 0;
	
	$(function() {
		
		// 이름 유효성 검증
		$('input[name=name]').focusout(function() {
			let name = $(this).val();
			if(!name.match(regName)){
				isNameOk=false;
				$('.resultName').css('color','red').text('이름은 한글 2자 이상이어야 합니다.');
			}else{
				isNameOk=true;
				$('.resultName').text('');
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
		$('.findId>form').submit(function(e) {
			
			// 폼 데이터 유효성 검증 Validation
			// 1.이름 검증
			if(!isNameOk){
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