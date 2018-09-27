<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>파일 업로드</h1>
<form action="upload.jsp" method="post" enctype="multipart/form-data">

학번 <input type="text" name="sno"><br>
파일<input type="file" name="file"><br>
<input type="submit" value="등록">

</form>
</body>
</html>