<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>
	<%
		Cookie[] cookies = request.getCookies();
		
		if(cookies !=null && cookies.length >0){
				for(int i=0;i<cookies.length;i++){
					
	%>
	
		<%=cookies[i].getName() %> = <%=cookies[i].getValue() %><br>
		EL : ${cookie.id.value}<br>
	<%
				}//end for i
		}else{
	%>
		저장된 쿠키정보가 없습니다.
	<%} %>
	아이디<input type="text" value="${cookie.id.value}"><br>
	</h1>
	<a href="editCookie.jsp">쿠키변경</a>
	<a href="deleteCookie.jsp">id 쿠키삭제</a>
</body>
</html>