
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="viewParam.jsp" method="post">
<table>
	<tr>
	  <td>이름</td>
	  <td><input type="text" name="userName"></td>
	</tr>
	<tr>
		<td>주소</td>
		<td><input type="text" name="address"></td>
	</tr>
	<tr>
		<td>좋아하는 동물</td>
		<td>
			<input type="checkbox" name="pet" value="dog">강아지 
			<input type="checkbox" name="pet" value="cat">고양이 
			<input type="checkbox" name="pet" value="pig">돼지
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<input type="submit" value="전송">
		<input type="reset" value="초기화">
		</td>
	</tr>
</table>	
</form>


</body>
</html>