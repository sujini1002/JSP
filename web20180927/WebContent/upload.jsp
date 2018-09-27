<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//확인용
	String sno = "";
	String fileName = "";
	String dir="";
	//1.multipart/form-data 여부 확인
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);

	if(isMultipart){
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List<FileItem> items = upload.parseRequest(request);
		
		Iterator<FileItem> itr = items.iterator();
		
		while(itr.hasNext()){
			FileItem item = itr.next();
			
			if(item.isFormField()){ //파일타입이 아닌 다른 타입들인가?(아닐때 true)
				String name = item.getFieldName();//sno
				String value = item.getString("utf-8");//value 값
				sno  = value;			
			}else{
				String name = item.getFieldName();
				String fName = item.getName();
				String contentType = item.getContentType(); // 파일 타입 확인
				boolean isInMemory = item.isInMemory();//메모리 존재 여부 확인
				long fileSize = item.getSize();//파일 크기
				
				
				fileName= fName + " : " + contentType + " : " +fileSize;
				
				//이 후 문장은 filesize가 0보다 클 때 만 처리 한다
				String uploadUri = "/file";
				dir = request.getSession(false).getServletContext().getRealPath(uploadUri);
				//파일저장
				item.write(new File(dir,fName));
				 
				 request.setAttribute("filename", fName); //openproject에서는 이미지 파일 이름을 id나 현재시간으로 한다.
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>학번 : <%=sno %></h1>
<h1>file : <%=fileName %></h1>
<h1><%=dir %></h1>
<img alt="이미지" src="<%=request.getContextPath()%>/file/${filename}">
</body>
</html>