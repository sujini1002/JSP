<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   	<jsp:useBean id="members" class="java.util.ArrayList" scope="application"/>
   	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원리스트</title>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
<%@ include file="/common/header.jsp" %>
	<c:if test="${empty members}">
			<h1>회원정보가 없습니다.</h1>
	</c:if>
	<table border=1>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>이미지</th>
			<th>관리</th>
		</tr>
		<c:forEach items="${members}" var="member">
	     	<tr>
			<td>${member.userId}</td>
			<td>${member.userName}</td>
			<td>${member.userImg}</td> 
			<td><a href="editForm.jsp?userid=${member.userId}">수정</a>&nbsp;&nbsp;&nbsp;
				<a href="delete.jsp?userid=${member.userId}">삭제</a>
			</td>
			</tr> 
		</c:forEach>
	</table>
</body>
</html>


