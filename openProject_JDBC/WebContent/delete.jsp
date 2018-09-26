<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String uid = request.getParameter("userid");
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String jdbcUrl = "jdbc:apache:commons:dbcp:open";

	int result = 0;
	try {
		conn = DriverManager.getConnection(jdbcUrl);

		String sql = "delete from members where userid=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, uid);

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
<h1>삭제 완료 <%=result%><a href="memberlist.jsp">회원리스트</a></h1>
</body>
</html>