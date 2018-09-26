<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="empReg.jsp">
	<table>
		<tr>
			<td>사원번호</td>
			<td><input type="text" name="empno"></td>
		</tr>
		<tr>
			<td>사원이름</td>
			<td><input type="text" name="ename"></td>
		</tr>
		<tr>
			<td>사원업무</td>
			<td><input type="text" name="job"></td>
		</tr>
		<tr>
			<td>입사일</td>
			<td><input type="date" name="hiredate"></td>
		</tr>
		<tr colspan="2"><input type="submit" value="등록"></tr>
	</table>
</form>
</body>
</html>