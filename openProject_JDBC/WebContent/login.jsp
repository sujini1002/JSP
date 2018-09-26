<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="openProject.memberInfo"%>
<%@ page import="openProject.loginForm"%>

<%
	//값 받아오기 
	String id = request.getParameter("userId");
	String pw = request.getParameter("password");

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	String jdbcUrl = "jdbc:apache:commons:dbcp:open";
	try {
		//2.컨넥션 객체 생성
		conn = DriverManager.getConnection(jdbcUrl);
		//3.Statement 객체 생성
		stmt = conn.createStatement();

		String sql = "select * from members where userid = Lower('" + id + "')";
		//4.쿼리실행
		rs = stmt.executeQuery(sql);

		if (rs.next() && rs.getString(2).equals(pw)) {
			//로그인 성공(세션에 저장)
			loginForm loginMember = new loginForm(rs.getString(1),rs.getString(3),rs.getString(4));
			request.getSession(false).setAttribute("loginMember", loginMember);
			response.sendRedirect("mypage.jsp");
		} else {
%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
	<%@ include file="/common/header.jsp"%>
	<div id="contents">
		<h2>로그인</h2>
		<hr>
		<h1>아이디 또는 비밀번호가 틀립니다. 확인해주세요.</h1>
		<h3>
			<a href="loginForm.jsp">다시로그인하기</a>
		</h3>

	</div>
</body>
</html>
<%
	}

	} finally {
		stmt.close();
		conn.close();
	}
%>