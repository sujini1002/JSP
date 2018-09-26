<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setAttribute("id", "cool"); %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
기본객체 사용 <br>
요청 URI : ${pageContext.request.requestURI}
<hr>
request id 속성값 확인 : ${requestScope.id}
<hr>
request 속성 확인 code: ${param.code}<!-- url 쿼리에 들어오는 부분을 받아오는 것 ?code=hot -->


</body>
</html>