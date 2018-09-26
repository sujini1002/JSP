<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="openProject.memberInfo" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   	<jsp:useBean id="members" class="java.util.ArrayList" scope="application"/>
   	<jsp:useBean id="editmember" class="openProject.memberInfo" scope="page"/>
   	<%
   		request.setCharacterEncoding("utf-8");
   		//String uid = request.getParameter("userid");
   	%> 
   	<%--  <c:set var="uid" value="${param.userid}" scope="request"/> --%> 
   	 <c:forEach items="${members}" var="item">
   		<c:if test="${item.userId eq param.userid}">  
			<jsp:setProperty property="userId" name="editmember" value="${item.userId}"/>
			<jsp:setProperty property="userPw" name="editmember" value="${item.userPw}"/>
			<jsp:setProperty property="userName" name="editmember" value="${item.userName}"/>
			<jsp:setProperty property="userImg" name="editmember" value="${item.userImg}"/>    			
   		</c:if>
   	</c:forEach>
   	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
<%@ include file="/common/header.jsp" %>

<form action="edit.jsp" method="post">
<table>

<tr>
	<td>아이디</td>
	<td><input type="text" name="userId" value="${editmember.userId}" readonly></td>
</tr>
<tr>
	<td>비밀번호</td>
	<td><input type="text" name="userPw" value="${editmember.userPw}" ></td>
</tr>
<tr>
	<td>이름</td>
	<td><input type="text" name="userName" value="${editmember.userName}" ></td>
</tr>
<tr>
	<td>이미지</td>
	<td><input type="file" name="userImg" value="${editmember.userImg}" ></td>
</tr>
<tr colspan="2"><input type="submit" value="수정완료"></tr>
</table>
</form>
</body>
</html>