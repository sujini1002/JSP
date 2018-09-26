<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	List<String> members = new ArrayList<String>();
	members.add("1홍길동");
	members.add("2철수");
	members.add("3영희");
	members.add("4수길동");
	members.add("5희수");
	members.add("6수희");
	members.add("7홍길순");
	members.add("8길수");
	members.add("9길희");
	
	request.setAttribute("members", members);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


<%-- <c:redirect url="/useELObject.jsp">
	<c:param name="code">1111</c:param>
</c:redirect> --%>
<hr>
<c:url value="/jstl3.jsp" var="targetl">
	<c:param name="sel">c</c:param>
</c:url>
경로 : ${targetl}
<br>
<a href="${targetl}">c페이지</a>
<hr>
<h3>
<c:choose>
	<c:when test="${param.sel == 'a'}">
		a를 선택
	</c:when>
	<c:when test="${param.sel == 'b'}">
		b를 선택
	</c:when>
	<c:when test="${param.sel == 'c'}">
		c를 선택
	</c:when>
	<c:otherwise>
		a,b,c이외의 선택
	</c:otherwise>
</c:choose>
</h3>
<select>
	<option ${param.sel=='a'?'selected':''}>a</option>
	<option ${param.sel=='b'?'selected':''}>b</option>
	<option ${param.sel=='c'?'selected':''}>c</option>
</select>
<hr>
<ul>
<c:forEach items="${members}" var="mem" begin="0" end="5" varStatus="status">
	<li>${status.index} - ${status.count} - ${mem}</li>
</c:forEach>
</ul>
<hr>
<table border=1>
<tr>
<th>이름</th><th>전화번호</th><th>이메일</th><th>거주지</th>
</tr>
<tr>
<c:forTokens items="홍기동|010-9999-2222|test@naver.com|서울" delims="|" var="sel">
	<td>${sel}</td>
</c:forTokens>
</tr>
</table>

</body>
</html>