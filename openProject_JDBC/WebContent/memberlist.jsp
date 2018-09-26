<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="openProject.loginForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="members" class="java.util.ArrayList" scope="page"/>
<%
			
			//선언 
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			
			String jdbcUrl = "jdbc:apache:commons:dbcp:open";
			
			try {
				//2.컨넥션 객체 생성
				conn=DriverManager.getConnection(jdbcUrl);
				//3.Statement 객체 생성
				stmt = conn.createStatement();

				String list_sql = "select *from members";

				//4.쿼리실행
				rs = stmt.executeQuery(list_sql);
				
					
					while(rs.next()){
						String id = rs.getString(1);
						String name = rs.getString(3);
						String img = rs.getString(4);
						members.add(new loginForm(id,name,img));
					}
				
				
			}finally{
				stmt.close();
				conn.close();
			}
			
		%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원리스트</title>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
	<%@ include file="/common/header.jsp"%>
	<c:if test="${empty members}">
	<h1>회원정보가 없습니다.</h1>
	</c:if>
	<table>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>이미지</th>
		</tr>
		
<c:forEach items="${members}" var="item">
		<tr>
			<td>${item.userId}</td>
			<td>${item.userName}</td>
			<td>${item.userImg}</td>
			<td><a href="editFrom.jsp?userid=${item.userId}">수정</a>&nbsp;&nbsp;&nbsp;
			<a href="delete.jsp?userid=${item.userId}">삭제</a></td>
		</tr>
</c:forEach>
	</table>
</body>
</html>