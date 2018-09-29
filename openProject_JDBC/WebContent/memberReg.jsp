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
 		String fileName = "";
 		String fName = "";
 		String id = "";
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

 			
 			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			if (isMultipart) {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				ServletFileUpload upload = new ServletFileUpload(factory);
				List<FileItem> items = upload.parseRequest(request);
				Iterator<FileItem> iter = items.iterator();
				int i=1;
				while (iter.hasNext()) {
					FileItem item = iter.next();
					if(!item.isFormField()){
						String Iname = item.getFieldName();
						 fName = item.getName();
						 fName += id; 
						String contentType = item.getContentType(); // 파일 타입 확인
						boolean isInMemory = item.isInMemory();//메모리 존재 여부 확인
						long fileSize = item.getSize();//파일 크기
						
						
						fileName= fName + " : " + contentType + " : " +fileSize;
						
						//이 후 문장은 filesize가 0보다 클 때 만 처리 한다
						if(fileSize>0){
						String uploadUri = "/images";
						String dir = request.getSession(false).getServletContext().getRealPath(uploadUri);
						System.out.println(dir);
						//파일저장
						item.write(new File(dir,fName));
						pstmt.setString(4,fName);
						}
						
					}else{
						pstmt.setString(i, item.getString("utf-8"));
						if(i==1){id=item.getString("utf-8");}
					}
					i++;
				}
			}
 			
 			
 			
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
                <td></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td></td>
            </tr>
            <tr>
                <td>이름</td>
                <td></td>
            </tr>
            <tr>
                <td>사진</td>
                <td></td>
            </tr>
        </table>
</div>

</body>
</html>