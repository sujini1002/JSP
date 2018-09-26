<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
//1.데이터 받기
	String uid = request.getParameter("userId");
	String upw = request.getParameter("userPw");
	String uname = request.getParameter("userName");
	String uimg = request.getParameter("userImg");
	

	int result = 0;

	//객체 선언
	Connection conn = null;
	PreparedStatement pstmt = null;

	String jdbcUrl = "jdbc:apache:commons:dbcp:open";

	try {
		//3.컨넥션 객체 생성
		conn = DriverManager.getConnection(jdbcUrl);

		//3.쿼리작성
		String sql = "update members set userpw=?,username=?,userimg=? where userid =?";

		pstmt = conn.prepareStatement(sql);//prepareStatement객체 생성
		pstmt.setString(1, upw);
		pstmt.setString(2, uname);
		pstmt.setString(3, uimg);
		pstmt.setString(4, uid);
		

		//4.쿼리 실행
		result = pstmt.executeUpdate();
	} finally {
		pstmt.close();
		conn.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%if(result==1) {%>
<h1>수정완료 </h1>
<%}else{ %>
<h1>수정실패</h1>
<%} %>
<a href="memberlist.jsp">회원리스트</a>
</body>
</html>