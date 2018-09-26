<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.Map" %>
    <%@ page import="java.util.HashMap" %>
    <%@ page import="openProject.memberInfo" %>
    <%@ page import="openProject.loginForm" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	//1.세션에서 loginMember를 가져온다.
	//2.로그인이 되어 있지 않으면(세션에 loginMember값이 없으면) alert을 띄우고 loginFrom.jsp로 이동한다.
	//3.로그인이 되어 있으면 해당 멤버의 정보를 띄운다.

	loginForm loginMember = (loginForm)request.getSession(false).getAttribute("loginMember");
	if(loginMember==null){
%>
		<script>
   			alert('로그인 후 사용가능한 서비스 입니다.');
   			location.href='loginForm.jsp';
   		</script> 	
    			
    <% 
    	}else{
    %>
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
<div id="memberPhoto">
<img src="user.png">
</div>
<hr>
        <table>
            <tr>
                <td>아이디(이메일)</td>
                <td><%= loginMember.getUserId() %></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><%=loginMember.getUserName() %></td>
            </tr>
        </table>
</div>
</body>
</html>
<%}%>