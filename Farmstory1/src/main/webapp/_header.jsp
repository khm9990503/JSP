<%@page import="kr.co.Farmstory1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	UserBean sessUser = (UserBean) session.getAttribute("sessUser");

	//if(sessUser == null){
	//	response.sendRedirect("/JBoard1/user/login.jsp?success=101");
	//	return; // 처리 종료
	//}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Farmstory</title>
    <link rel="stylesheet" href="/Farmstory1/css/style.css ">
    <link rel="stylesheet" href="/Farmstory1/user/css/style.css ">
    <link rel="stylesheet" href="/Farmstory1/board/css/style.css ">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/smoothness/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
    <script>
        $(document).ready(function(){
        $('.slider2').bxSlider();

        $( "#tabs" ).tabs();
        });
    </script>
</head>
<body>
    <div id="wrapper">
        <header>
            <a href="/Farmstory1/index.jsp" class="logo">
                <img src="/Farmstory1/img/logo.png" alt="logo">
            </a>
            <%if(sessUser==null){ %>
            <p>
                <a href="/Farmstory1/">HOME |</a>
                <a href="/Farmstory1/user/login.jsp">로그인 |</a>
                <a href="/Farmstory1/user/terms.jsp">회원가입 |</a>
                <a href="#">고객센터</a>
            </p>
            <%}else { %>
            <p>
            	<a href="/Farmstory1/">HOME |</a>
	            <span class="nick"><%=sessUser.getNick() %></span>님 반갑습니다.
	            <a href="/Farmstory1/user/proc/logout.jsp" class="logout">[로그아웃]</a>
            </p>
            <%} %>
            <img src="/Farmstory1/img/head_txt_img.png" alt="3만원 이상 무료배송">
            <ul class="gnb">
                <li>
                    <a href="/Farmstory1/introduction/hello.jsp"></a>
                </li>
                <li>
                    <a href="/Farmstory1/board/list.jsp?group=market&cate=market"></a>
                </li>
                <li>
                    <a href="/Farmstory1/board/list.jsp?group=story&cate=story"></a>
                </li>
                <li>
                    <a href="/Farmstory1/board/list.jsp?group=event&cate=event"></a>
                </li>
                <li>
                    <a href="/Farmstory1/board/list.jsp?group=community&cate=notice"></a>
                </li>
            </ul>
        </header>
