<%@page import="java.io.InputStreamReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String path = "/message/notice/test.html";
		
	%>
	<%= application.getRealPath(path)%>
	
	<%
		BufferedReader br = null;
		char[] buff = new char[512];
		int len = -1;
		
		br = new BufferedReader(new InputStreamReader(application.getResourceAsStream(path)));
		
		while((len = br.read(buff))!= -1){
			out.print(new String(buff,0,len));
		}
	%>
</body>
</html>