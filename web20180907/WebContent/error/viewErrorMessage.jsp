<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>에러발생</title>
</head>
<body>
요청과정에서 에러가 발생했습니다.
빠른 시간내에 처리하겠습니다.

<h3>에러타입 : <%=exception.getClass().getName() %></h3>
<h3>에러 메세지: <%= exception.getMessage() %></h3>


</body>
</html>