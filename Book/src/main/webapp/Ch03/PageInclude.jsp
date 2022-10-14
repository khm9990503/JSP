<%@page import="common.Person"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int pInteger2 = (Integer)(pageContext.getAttribute("pageInteger"));
	//String pString2 = pageContext.getAttribute("pageString").toString();
	Person pPerson2 = (Person)(pageContext.getAttribute("pagePerson"));
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>pageInclude</title>
	</head>
	<body>
		<h4>include 페이지</h4>
		<ul>
			<li>Integer 객체 : <%=pInteger2 %></li>
			<li>String 객체 : <%=pageContext.getAttribute("pageString") %></li>
			<li>Person 객체 : <%=pPerson2.getName() %>,<%=pPerson2.getAge() %></li>
		</ul>
	</body>
</html>