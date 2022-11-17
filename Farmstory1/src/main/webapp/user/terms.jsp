<%@page import="kr.co.Farmstory1.dao.TermsDao"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<script>
	$(function() {
		
		$('.next').click(function() {
			
			let ischeck1 = $('input[class=terms]').is(":checked");
			let ischeck2 = $('input[class=privacy]').is(":checked");
			
			if(ischeck1 && ischeck2){
				return true;
			}else{
				alert('동의 체크를 하셔야 합니다.');
				return false;	
			}
		});
	});
</script>
<%
	request.setCharacterEncoding("utf-8");
	List<String> ts = TermsDao.getInstance().selectTerms();
%>
        <main id="user" class="terms">
            <table border="0">
                <caption>사이트 이용약관</caption>
                <tr>
                    <td>
                        <textarea class="terms" readonly><%=ts.get(0) %></textarea>
                        <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
                    </td>
                </tr>
            </table>
            <table border="0">
                <caption>개인정보 취급방침</caption>
                <tr>
                    <td>
                        <textarea class="privacy"><%=ts.get(1) %></textarea>
                        <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
                    </td>
                </tr>
            </table>
            <p>
                <a href="./login.jsp" class="cancel">취소</a>
                <a href="./register.jsp" class="next">다음</a>
            </p>
        </main>
<%@ include file="../_footer.jsp" %>