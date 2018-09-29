<%@page import="openProject.memberInfo"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
	memberInfo memberInfo = new memberInfo();
//1.multipart/form -data 여부 확인
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {
		DiskFileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	List<FileItem> items = upload.parseRequest(request);
	
	Iterator<FileItem> itr = items.iterator();
	
	while (itr.hasNext()) {
		FileItem item = itr.next();
		if(item.isFormField()){
			if(item.getFieldName().equals("userId")){
				memberInfo.setUserId(item.getString("utf-8"));
			}
			if(item.getFieldName().equals("userPw")){
				memberInfo.setUserPw(item.getString("utf-8"));
			}
			if(item.getFieldName().equals("userName")){
				memberInfo.setUserName(item.getString("utf-8"));
			}
		}else{ //파일이 타입인 경우
			if(item.getFieldName().equals("userImg")&&item.getSize()>0 
					&& item.getName()!=null 
					&& item.getName().length()>0){
				//물리적인 file의 저장
				//memberInfo.setUserImg()에 저장
				String newFileName = "";
				String fileName = item.getName(); //파일이름 가져오기
				newFileName = System.currentTimeMillis()+"_"+fileName;//long + String = 문자열
				
				//저장경로만들기
				String uploadUri = "/uploadFile";
				//uploadFile의 절대경로를 찾는 문장
				String dir = request.getSession().getServletContext().getRealPath(uploadUri);
				
				File file = new File(dir,newFileName);
				
				//물리적인 저장
				item.write(file);
				
				memberInfo.setUserImg(newFileName);
			}
		}
	}//end while
	}
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
		pstmt.setString(1, memberInfo.getUserPw());
		pstmt.setString(2, memberInfo.getUserName());
		pstmt.setString(3, memberInfo.getUserImg());
		pstmt.setString(4, memberInfo.getUserId());
	

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