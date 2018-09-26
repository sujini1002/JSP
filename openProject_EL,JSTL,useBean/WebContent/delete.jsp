<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("utf-8"); %>
    <jsp:useBean id="members" class="java.util.HashMap" scope="application"/>
    <% 
    	String id = request.getParameter("userid");
    	boolean isDelete = false;
    	if(members.get(id)!=null){
    		members.remove(id);
    		isDelete = true;
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
<% if(isDelete){ %>
<h1>삭제완료</h1>
<%}else{ %>
<h1>삭제실패</h1>
<%} %>
<a href="memberlist.jsp">회원리스트</a>
</body>
</html>