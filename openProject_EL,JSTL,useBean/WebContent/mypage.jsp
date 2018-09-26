<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="sessionMember" class="openProject.loginForm" scope="session"/>

<c:if test="${empty sessionMember.userId}">
<script>
alert("로그인 후 이용가능한 페이지 입니다.");
location.href = 'loginForm.jsp';
</script>
</c:if>
<c:if test="${empty sessionMember.userId eq false}">
	

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/default.css">
<style type="text/css">
 #memberPhoto{
 	background-image:url("images/user.png");
 	background-size:100%;
 	width :150px;
 	height:150px;
 	border : 1px solid #DDDDDD;
 	border-radius: 75px;
 	margin :10px
 }
</style>
</head>
<body>
<%@ include file="/common/header.jsp" %>
<div id="contents">
<h2>회원정보</h2>
<div id="memberPhoto"></div>
<hr>
        <table>
            <tr>
                <td>아이디(이메일)</td>
                <td>${sessionMember.userId}</td>
            </tr>
            <tr>
                <td>이름</td>
                <td>${sessionMember.userName}</td>
            </tr>
        </table>
</div>
</body>
</html>
</c:if>