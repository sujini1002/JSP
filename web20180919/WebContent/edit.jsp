<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	//1.데이터 받기
	String empno = request.getParameter("empno");
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");

	int result = 0;

	//2.데이터 베이스 로드
	//Class.forName("oracle.jdbc.driver.OracleDriver");
	//객체 선언
	Connection conn = null;
	PreparedStatement pstmt = null;

	/* String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "scott";
	String pw = "1234"; */
	String jdbcUrl = "jdbc:apache:commons:dbcp:open";

	try {
		//3.컨넥션 객체 생성
		conn = DriverManager.getConnection(jdbcUrl);

		//3.쿼리작성
		String sql = "update emp set ename=?,job=? where empno =?";

		pstmt = conn.prepareStatement(sql);//prepareStatement객체 생성
		pstmt.setString(1, ename);
		pstmt.setString(2, job);
		pstmt.setInt(3, Integer.parseInt(empno));

		//4.쿼리 실행
		result = pstmt.executeUpdate();
	} finally {
		pstmt.close();
		conn.close();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>
		<%
			if (result > 0) {
		%>
		수정완료
		<%
			} else {
		%>
		수정실패
		<%
			}
		%>
		<a href="emp_list.jsp">emp_List</a>

	</h1>
</body>
</html>