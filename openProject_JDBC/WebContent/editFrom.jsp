<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
	String userId = request.getParameter("userid");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	String jdbcUrl = "jdbc:apache:commons:dbcp:open";

	//2.컨넥션 객체 생성
	conn = DriverManager.getConnection(jdbcUrl);
	//3.Statement 객체 생성
	stmt = conn.createStatement();//prepareStatement 사용시에도 적어야 한다.
	String sql = "select * from members where userid = Lower('" + userId+"')";


	rs = stmt.executeQuery(sql);
	String uname = "";
	String upw = "";

	if (rs.next()) {
		upw = rs.getString(2);
		uname = rs.getString(3);
	}else{
		System.out.println("없음");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="edit.jsp">
	<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="userId" readonly
				value="<%=userId%>"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="userPw" value="<%=upw%>"></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="userName" value="<%=uname%>"></td>
		</tr>
		<tr>
			<td>이미지</td>
			<td><input type="file" name="userImg" ></td>
		</tr>
		<tr colspan="2">
			<input type="submit" value="완료">
		</tr>
	</table>
	</form>
</body>
</html>