<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="openProject.loginForm" %>
<body>
<h1 class="title">OpenProject</h1>
<ul id="gnb">
	<li><a href="index.jsp">HOME</a></li>
    <li><a href="memberRegForm.jsp">회원가입</a></li>
    <%
    loginForm lid = (loginForm)request.getSession(false).getAttribute("loginMember");
    if(lid==null){
    %>
    <li><a href="<%=request.getContextPath() %>/loginForm.jsp">로그인</a></li>
    <%}else{ %>
     <li><a href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a></li>
    <%} %>
    <li><a href="<%=request.getContextPath() %>/mypage/mypage.jsp">마이페이지</a></li>
    <li><a href="<%=request.getContextPath() %>/memberlist.jsp">회원리스트</a></li>
</ul>
</body>
</html>