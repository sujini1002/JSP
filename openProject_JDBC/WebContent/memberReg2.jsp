<%@page import="openProject.memberInfo"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%--   <% request.setCharacterEncoding("utf-8"); %> --%>
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
			pstmt.setString(1, memberInfo.getUserId());
			pstmt.setString(2, memberInfo.getUserPw());
			pstmt.setString(3, memberInfo.getUserName());
			pstmt.setString(4, memberInfo.getUserImg());
 			resultCnt = pstmt.executeUpdate();
 			
 		}catch(SQLException e){
 		%>
 			<script>
 				alert("이미 있는 아이디 입니다.");
 				location.href = 'memberRegForm.jsp';
 			</script>
 		<%
 		e.printStackTrace();
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
                <td><%= memberInfo.getUserId() %></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><%= memberInfo.getUserPw() %></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><%= memberInfo.getUserName() %></td>
            </tr>
            <tr>
                <td>사진</td>
                <!-- JSTL로 변경 -->
                <td><img alt="회원님사진" src="<%=request.getContextPath()+"/uploadFile/"+memberInfo.getUserImg()%>"></td>
            </tr>
        </table>
</div>

</body>
</html>