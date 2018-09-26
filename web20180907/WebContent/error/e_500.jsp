<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
500에러 서버가 작동되지 않습니다.
빠른 시간내에 처리하겠습니다.

<h3>에러타입 : <%=exception.getClass().getName() %></h3>
<h3>에러 메세지: <%= exception.getMessage() %></h3>
</body>
</html>