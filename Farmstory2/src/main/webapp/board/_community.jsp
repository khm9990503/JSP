<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate = request.getParameter("cate");
%>
<div id="sub">
    <div>
        <img src="/Farmstory2/img/sub_top_tit5.png" alt="intro">
    </div>
    <section class="cate5">
        <aside>
            <img src="/Farmstory2/img/sub_aside_cate5_tit.png" alt="소개">
            <ul class="lnb">
                <li class="<%=cate.equals("notice") ? "on" : "off"%>">
                    <a href="/Farmstory2/board/list.do?group=community&cate=notice"></a>
                </li>
                <li class="<%=cate.equals("today") ? "on" : "off"%>">
                    <a href="/Farmstory2/board/list.do?group=community&cate=today"></a>
                </li>
                <li class="<%=cate.equals("chef") ? "on" : "off"%>">
                    <a href="/Farmstory2/board/list.do?group=community&cate=chef"></a>
                </li>
                <li class="<%=cate.equals("one") ? "on" : "off"%>">
                    <a href="/Farmstory2/board/list.do?group=community&cate=one"></a>
                </li>
                <li class="<%=cate.equals("question") ? "on" : "off"%>">
                    <a href="/Farmstory2/board/list.do?group=community&cate=question"></a>
                </li>
            </ul>
        </aside>
        <article>
            <nav>
                <img src="/Farmstory2/img/sub_nav_tit_cate5_<%=cate%>.png" alt="인사말">
                <p>
                    HOME > 커뮤니티 > 
                    <%if(cate.equals("notice")){ %>
                    <em>공지사항</em>
                    <%}else if(cate.equals("today")){ %>
                    <em>오늘의식단</em>
                    <%}else if(cate.equals("chef")){ %>
                    <em>나도요리사</em>
                    <%}else if(cate.equals("one")){ %>
                    <em>1:1고객문의</em>
                    <%}else if(cate.equals("question")){ %>
                    <em>자주묻는질문</em>
                    <%} %>
                    
                </p>
            </nav>