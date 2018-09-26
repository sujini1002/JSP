<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("utf-8");
 %>
 <%@ page import="java.util.Enumeration" %>
 <%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
 	String userName = request.getParameter("userName");
	String address = request.getParameter("address");
%>

userName 파라미터 : <%=userName %><br>
address 파라미터 : <%= address %><br>

<%
	String[] pets = request.getParameterValues("pet");
	if(pets != null){
		for(int i=0;i<pets.length;i++){
%>
			<%= pets[i] %><br>
<% 
		}	
	 }
%>

<hr>
<%
	  Enumeration enumParam =request.getParameterNames();
	  while(enumParam.hasMoreElements()){
		  String name = (String)enumParam.nextElement();
		  %>
		    <%=name %><%=request.getParameter(name) %><br>
		  <%
	  }
%>
<hr>
<%
	Map mapParam =request.getParameterMap();
	String[] userNames = (String[])mapParam.get("userName");
	if(userNames != null){
		%>
			userName : <%= userNames[0] %>
		<%
	}
	
%>
</body>
</html>