<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>사원 리스트</h1>
<h3><a href="empRegFrom.jsp">사원등록</a></h3>
	<table border="1">
		<tr>
			<td>사원번호</td>
			<td>사원이름</td>
			<td>직급</td>
			<td>관리</td>
		</tr>
		<%
			//1.데이터베이스 드라이버 로드 객체 선언
			//Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			/* String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "scott";
			String pw = "1234"; */
			String jdbcUrl = "jdbc:apache:commons:dbcp:open";
			
			try {
				//2.컨넥션 객체 생성
				//conn = DriverManager.getConnection(url, user, pw);
				conn=DriverManager.getConnection(jdbcUrl);
				//3.Statement 객체 생성
				stmt = conn.createStatement();//prepareStatement 사용시에도 적어야 한다.

				String list_sql = "select empno,ename,job from emp order by empno";

				//4.쿼리실행
				rs = stmt.executeQuery(list_sql);
				if (rs.next()) {
					 do{
		%>
		<tr>
			<td><%=rs.getInt(1)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(3)%></td>
			<td>
				<a href="editForm.jsp?empno=<%=rs.getInt(1)%>">수정</a>
				<a href="delete.jsp?empno=<%=rs.getInt(1) %>">삭제</a>
			</td>
		</tr>
		<%
			}while (rs.next()); //end while
				} else {
		%>
		<tr colspan="3">등록된 정보가 없습니다.
		</tr>
		<%
			}//end else
			} finally {
				if(rs != null){
					try{
					rs.close();
					}catch(SQLException e){}
				}
				if(stmt != null){
					try{
						stmt.close();
						}catch(SQLException e){}
				}
				if(conn != null){
					try{
						conn.close();
						}catch(SQLException e){}
				}
			}
		%>

	</table>
</body>
</html>