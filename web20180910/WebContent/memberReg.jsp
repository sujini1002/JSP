<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %><!-- useBean전에 한글처리하기위한 인코딩문 반드시 쓰기 -->
<jsp:useBean id="member" class="member.MemberInfo"/>
<jsp:setProperty property="*" name="member"/><!-- 가장 중요!!!!많은 데이터를 한번에 불러 올 때 '*'사용  -->
<jsp:setProperty property="password" name="member" value="<%=member.getId() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>회원가입정보</h1>
<table>
	<tr>
		<td>아이디</td>
		<td><%= member.getId() %>/EL:${member.id}</td>
		<!-- ${pagescope(requsetscope/requestscope/sessionscope/applicationscope).member.id}가 정석이다 -->
	</tr>
	<tr>
		<td>이름</td>
		<td><%= member.getName() %></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><%= member.getPassword() %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><%= member.getEmail() %></td>
	</tr>
	<tr>
		<td>주소</td>
		<td><%= member.getAddress() %></td>
	</tr>
</table>
</body>
</html>