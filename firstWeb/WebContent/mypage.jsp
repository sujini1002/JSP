<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="firstWeb.memberInfo" %>
    <%
    		
    	memberInfo member = (memberInfo)request.getSession(false).getAttribute("loginInfo");
    	if(member.getUserId()==null){
    %>
   		<script>
   			alert('로그인 후 사용가능한 서비스 입니다.');
   			location.href='loginForm.jsp';
   		</script> 	
    			
    <% 
    	}else{
    %>
 <%--
 	<%
    	request.setCharacterEncoding("utf-8"); 
 		String userId = request.getParameter("userId");
 		String password = request.getParameter("password");
 		String userName = request.getParameter("userName");
	%>
 --%>
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
                <td><%=member.getUserId() %></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><%=member.getUserName() %></td>
            </tr>
        </table>
</div>
</body>
</html>
<%}%>