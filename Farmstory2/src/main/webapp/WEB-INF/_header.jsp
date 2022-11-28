<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Farmstory::index</title>
    <link rel="stylesheet" href="/Farmstory2/css/style.css ">
    <link rel="stylesheet" href="/Farmstory2/css/UserStyle.css ">
    <link rel="stylesheet" href="/Farmstory2/css/BoardStyle.css ">
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
            <a href="/Farmstory2/index.jsp" class="logo">
                <img src="/Farmstory2/img/logo.png" alt="logo">
            </a>
            <p>
                <a href="/Farmstory2/index.do">HOME |</a>
                <a href="/Farmstory2/user/login.do">로그인 |</a>
                <a href="/Farmstory2/user/terms.do">회원가입 |</a>
                <a href="#">고객센터</a>
            </p>
            <img src="/Farmstory2/img/head_txt_img.png" alt="3만원 이상 무료배송">
            <ul class="gnb">
                <li>
                    <a href="/Farmstory2/introduction/hello.do"></a>
                </li>
                <li>
                    <a href="/Farmstory2/board/list.do?group=market&cate=market"></a>
                </li>
                <li>
                    <a href="/Farmstory2/board/list.do?group=story&cate=story"></a>
                </li>
                <li>
                    <a href="/Farmstory2/board/list.do?group=event&cate=event"></a>
                </li>
                <li>
                    <a href="/Farmstory2/board/list.do?group=community&cate=notice"></a>
                </li>
            </ul>
        </header>