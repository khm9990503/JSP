<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate = request.getParameter("cate");
%>
<div id="sub">
    <div>
        <img src="../img/sub_top_tit3.png" alt="intro">
    </div>
    <section class="cate3">
        <aside>
            <img src="../img/sub_aside_cate3_tit.png" alt="소개">
            <ul class="lnb">
                <li class="<%=cate.equals("story") ? "on" : "off"%>">
                    <a href="/Farmstory1/board/list.jsp?group=story&cate=story"></a>
                </li>
                <li class="<%=cate.equals("story2") ? "on" : "off"%>">
                    <a href="/Farmstory1/board/list.jsp?group=story&cate=story2"></a>
                </li>
                <li class="<%=cate.equals("story3") ? "on" : "off"%>">
                    <a href="/Farmstory1/board/list.jsp?group=story&cate=story3"></a>
                </li>
            </ul>
        </aside>
        <article>
            <nav>
                <img src="../img/sub_nav_tit_cate3_<%= cate %>.png" alt="인사말">
                <p>
                    HOME > 농작물이야기 > 
                    <%if(cate.equals("story")){ %>
                    <em>농작물이야기</em>
                    <% }else if(cate.equals("story2")){ %>
                    <em>텃밭가꾸기</em>
                    <% }else if(cate.equals("story3")){ %>
                    <em>귀농학교</em>
                    <%} %>
                </p>
            </nav>