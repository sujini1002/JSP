	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ page import="java.util.HashMap" %>
    <% request.setCharacterEncoding("utf-8"); %>
    <jsp:useBean id="member" class="openProject.memberInfo" scope="page"/>
    <jsp:useBean id="members" class="java.util.HashMap" scope="application"/>
    <jsp:setProperty name="member" property="*"/>
    <%
    	members.put(member.getUserId(),member);
    %>
 	<!-- application에 members가 없으면 새로 생성하여 요청된 값을 받아고 있으면 기존 어플리케이션에 있는 값을  map에 저장한뒤 다시 어플리케이션에 저장  -->
<%--  	<% HashMap<String,memberInfo>map = null; %>
 	<c:choose>
 		<c:when test="${applicationScope.members ne null}">
 			<%map = (HashMap)application.getAttribute("members");%>
 		</c:when>
 		<c:when test="${applicationScope.members eq null}">
 			<% map = new HashMap();%>
 		</c:when>
 	</c:choose> 
 	<%
 		map.put(member.getUserId(),member);
 		application.setAttribute("members", map);
 	%> --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
<%@ include file="/common/header.jsp" %>
<div id="contents">
<h2>회원가입</h2>
        <table>
            <tr>
                <td>아이디(이메일)</td>
                <td>${member.userId}</td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td>${member.userPw}</td>
            </tr>
            <tr>
                <td>이름</td>
                <td>${member.userName}</td>
            </tr>
            <tr>
                <td>사진</td>
                <td>${member.userImg}</td>
            </tr>
        </table>
</div>

</body>
</html>