<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <jsp:useBean id="sessionMember" class="openProject.loginForm" scope="session"/> --%>
<%
	request.getSession(false).getAttribute("sessionMember");
%>

<body>
<h1 class="title">OpenProject</h1>
<ul id="gnb">
	<li><a href="index.jsp">HOME</a></li>
    <li><a href="memberRegForm.jsp">회원가입</a></li>
   <c:if test="${empty sessionMember.userId}">
    <li><a href="loginForm.jsp">로그인</a></li>
 	</c:if>
 	<c:if test="${empty sessionMember.userId eq false}">
     <li><a href="logout.jsp">로그아웃</a></li>
    </c:if>
    <li><a href="mypage.jsp">마이페이지</a></li>
    <li><a href="memberlist.jsp">회원리스트</a></li>
</ul>
</body>
</html>