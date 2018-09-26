<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="members" class="java.util.HashMap" scope="application" />
<jsp:useBean id="edit" class="openProject.memberInfo" />
<jsp:setProperty property="*" name="edit" />
<%
	String uid = request.getParameter("userId");
	boolean isUpdate = false;
	if (members.get(uid) != null) {
		members.replace(uid, edit);
		isUpdate=true;
	}
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
<% if(isUpdate){ %>
<h1>수정완료</h1>
<% }else{ %>
<h1>수정실패</h1>
<%} %>
<a href="memberlist.jsp">회원리스트</a>
</body>
</html>