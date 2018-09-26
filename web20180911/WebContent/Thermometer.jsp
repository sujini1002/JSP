<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="Thermometer.Thermometer" %>
    <%
    	Thermometer t = new Thermometer();
    	request.setAttribute("t", t);
    %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
${t.setCelsius(param.loc,param.val)}<!-- get방식에서 쿼리문자열으로 값을 받아옴 -->
<%-- ${t.setCelsius('서울',27.3)} --%><!-- 단순히 값 설정 일뿐 출력하는 것은 없음(return값이 없다면) --> 온도 설정<br>
서울 온도 :  섭씨- ${t.getCelsius('서울')}
<br>
서울 온도 : 화씨 -${t.getFahrenheit('서울')}
<br>
정보 : ${t.info}
</body>
</html>