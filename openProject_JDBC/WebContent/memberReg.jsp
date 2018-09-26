<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("utf-8"); %>
 	<%
 		 String id=request.getParameter("userId");
 		String pw=request.getParameter("userPw");
 		String name = request.getParameter("userName");
 		String img =request.getParameter("userImg");
 		
 		Connection conn=null;
 		PreparedStatement pstmt = null;
 		int resultCnt = 0;
 		
 		String jdbcUrl = "jdbc:apache:commons:dbcp:open";
 		
 		try{
 			//컨넥션 연결
 			conn = DriverManager.getConnection(jdbcUrl);
 			//쿼리 작성
 			String sql1 = "insert into members values(?,?,?,?)";
 			pstmt = conn.prepareStatement(sql1);

 			pstmt.setString(1,id);
 			pstmt.setString(2,pw);
 			pstmt.setString(3,name);
 			pstmt.setString(4,img);
 			
 			resultCnt = pstmt.executeUpdate();
 			
 		}catch(SQLException e){
 		%>
 			<script>
 				alert("이미 있는 아이디 입니다.");
 				location.href = 'memberRegForm.jsp';
 			</script>
 		<%
 		}
 		finally{
 			pstmt.close();//커넥션 풀 사용 시 , 컨넥션은 풀에 반환된다.
 			conn.close();
 		} 
 		
 	%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
<%@ include file="/common/header.jsp" %>
<div id="contents">
<h2>회원가입</h2>
        <table>
            <tr>
                <td>아이디(이메일)</td>
                <td><%=id %></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><%=pw %></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><%=name %></td>
            </tr>
            <tr>
                <td>사진</td>
                <td><%=img %></td>
            </tr>
        </table>
</div>

</body>
</html>