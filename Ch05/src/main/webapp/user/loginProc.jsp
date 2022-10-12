<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");
	
	if(pw.equals("1234")){
		// 회원 맞음
		
		// 자동 로그인 처리
		if(auto!=null){
			Cookie cookie = new Cookie("cid",id);
			cookie.setMaxAge(60*3); // 3분
			
			response.addCookie(cookie); // 쿠키 달아놓기. redirect 할 때 딸려간다.
			
		}
		
		session.setAttribute("sessid", id); // cliest id 랑 id 연결 (상태정보 저장)
		response.sendRedirect("./loginSuccess.jsp");
	}else {
		// 아님
		response.sendRedirect("./login.jsp");
	}
%>