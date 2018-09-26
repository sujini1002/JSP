<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	List<String> members = new ArrayList<String>();
	members.add("홍길동");
	members.add("철수");
	members.add(null);
	members.add("영희");
	
	request.setAttribute("members", members);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border=1>
	<c:forEach var="name" items="${members}">
	<tr>
		<td>
			<c:out value="${name}" escapeXml="false">
				<span style="color:orange;">이름이 없다.</span>
			</c:out>
		</td>
	</tr>
	</c:forEach>
</table>
</body>
</html>