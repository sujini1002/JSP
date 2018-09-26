<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="openProject.memberInfo" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="members" class="java.util.ArrayList" scope="application" />
<jsp:useBean id="edit" class="openProject.memberInfo" />
<jsp:setProperty property="*" name="edit" />
<%
	boolean isUpdate = false;
	for(int i =0;i<members.size();i++){
		memberInfo tmp = (memberInfo)members.get(i);
		if(tmp.getUserId().equals(edit.getUserId())){
			members.set(i, edit);
			isUpdate = true;
			break;
		}
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