<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.Map" %>
    <%@ page import="java.util.HashMap" %>
    <%@ page import="openProject.memberInfo" %>
    <%@ page import="openProject.loginForm" %>
   <%--  <jsp:useBean id="loginMember" class="openProject.loginForm" scope="session"/> --%>
	<% loginForm loginMember =(loginForm)request.getSession(false).getAttribute("loginMember"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/default.css">
<style type="text/css">
 #memberPhoto>img{
 	
 	background-size:100%;
 	width :150px;
 	height:150px;
 	border : 5px solid #000000;
 	border-radius: 75px;
 	margin :10px
 }
 
</style>
</head>
<body>
<%@ include file="/common/header.jsp" %>
<div id="contents">
<h2>회원정보</h2>
<div id="memberPhoto">
<img src="<%=request.getContextPath() %>/uploadFile/${loginMember.userImg}">
</div>
<hr>
        <table>
            <tr>
                <td>아이디(이메일)</td>
                <td><%=loginMember.getUserId() %></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><%=loginMember.getUserName() %></td>
            </tr>
        </table>
</div>
</body>
</html>
