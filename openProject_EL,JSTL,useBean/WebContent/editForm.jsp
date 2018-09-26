<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="openProject.memberInfo" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   	<jsp:useBean id="members" class="java.util.HashMap" scope="application"/>
   	
   	<%
   		request.setCharacterEncoding("utf-8");
   		String uid = request.getParameter("userid");
   		memberInfo editmember = (memberInfo)members.get(uid);
   		request.setAttribute("editmember", editmember);
   	%> 
   	
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