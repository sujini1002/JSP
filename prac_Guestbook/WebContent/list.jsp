<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="writeMessage.jsp">
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="guestName"></td>
			</tr>
			<tr>
				<td>암호</td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td>메세지</td>
				<td><textarea name="message" cols="30" row="3"></textarea></td>
			</tr>
			<tr colsapan="2">
				<td><input type="submit" value="남기기"></td>
			</tr>
		</table>
	</form>
<hr>
</body>
</html>