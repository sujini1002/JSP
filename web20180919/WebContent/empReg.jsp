<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1.값 받아오기
	request.setCharacterEncoding("utf-8");
	String empno = request.getParameter("empno");
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	String date = request.getParameter("hiredate");
	
	int result= 0;
	int empcheck= 0;
	//2.데이터 베이스 로드
	//Class.forName("oracle.jdbc.driver.OracleDriver");
	//객체 선언
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	/* String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "scott";
	String pw = "1234"; */
	String jdbcUrl = "jdbc:apache:commons:dbcp:open";
	
	try{
		//3.컨넥션연결
		conn = DriverManager.getConnection(jdbcUrl);
		
		
		//4.쿼리작성
		String sql = "select empno from emp where empno ="+empno;
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(!rs.next()){
			String sql2 = "insert into emp(empno,ename,job,hiredate) values(?,?,?,to_date(?,'yy/mm/dd'))";
			
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, Integer.parseInt(empno));
			pstmt.setString(2, ename);
			pstmt.setString(3, job);
			pstmt.setString(4,date);
			result = pstmt.executeUpdate();
		}else{
			empcheck =1;
		}
		
		
		
	}finally{
		
		pstmt.close();//커넥션 풀 사용 시 , 컨넥션은 풀에 반환된다.
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

<% if(empcheck==1){%>
<h1 style="color:red">등록된 사원번호 </h1>
<%}else if(result >0){ %>
<h1>
등록완료
<%}else{ %>
등록실패
<%} %>
<a href="emp_list.jsp">emp_List</a>
</h1>
</body>
</html>