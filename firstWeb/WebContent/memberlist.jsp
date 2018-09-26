<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.util.ArrayList" %>
   <%@ page import="firstWeb.memberInfo" %>
   <%
   		//리스트를 생성한다.
   		ArrayList member_list = null;
   		if(application.getAttribute("member_list")!=null){
   			member_list=(ArrayList)application.getAttribute("member_list");
   		}
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원리스트</title>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
<%@ include file="/common/header.jsp" %>
	<table>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>이미지</th>
		</tr>
	
		
	    <% 
	    	if(member_list == null){
	    %>
	    		<h1>회원이 없습니다.</h1>
	    		
	    <%
	    	}else{
	    	for(int i=0;i<member_list.size();i++){
	    		memberInfo member = (memberInfo)member_list.get(i);
	    %>	
	    	<tr>
	    	
			<td><%= member.getUserId()%></td>
			<td><%= member.getUserName() %></td>
			<td><%= member.getUserImg() %></td>
			</tr>
	   <%}
	   }%>
	</table>
</body>
</html>