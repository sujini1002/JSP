<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String empno = request.getParameter("empno");
	//1.데이터베이스 드라이버 로드 객체 선언
	//Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = null;
	PreparedStatement pstmt = null;
	/* String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "scott";
	String pw = "1234"; */
	String jdbcUrl = "jdbc:apache:commons:dbcp:open";
	
	int result =0;
	try{
	conn = DriverManager.getConnection(jdbcUrl);
	
	String sql = "delete from emp where empno=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(empno));
	
	result = pstmt.executeUpdate();
	}finally{
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
<h1>삭제 완료 <%=result%><a href="emp_list.jsp">emp_List</a></h1>
</body>
</html>