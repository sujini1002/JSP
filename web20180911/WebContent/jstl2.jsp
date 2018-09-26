<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="test.Member" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
   <% 
	Member member = new Member(); 
	
	member.setName("강수진");
	member.setEmail("aufclakstp@naver.com");
	
	request.setAttribute("member", member);
   %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
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
<c:set var="str" value="java"/>
msg : ${str}<br>
<c:if test="${true}" var="result">
	참입니다.
	
</c:if>
<br>
<c:if test="${str=='java'}" var="result">
	Test Result: ${result}
</c:if>
<hr>

<c:set var="msg" value="JAVA"/><!-- scope생략시 범위는 page이다. -->
msg:${msg}<br>
msg:<%=pageContext.getAttribute("msg")%><br>
<hr>
<c:set target="${member}" property="email" value="test@test.com"/>
Member name : ${member.name}<br>
Member email : ${member.email}<br>

</body>
</html>