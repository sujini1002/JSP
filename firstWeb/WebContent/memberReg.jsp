<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="firstWeb.memberInfo" %>
 <%
    	request.setCharacterEncoding("utf-8"); 
 		String userId = request.getParameter("userId");
 		String password = request.getParameter("password");
 		String userName = request.getParameter("userName");
 		//memberInfo타입의 객체 생성
 		memberInfo member = new memberInfo(userId,password,userName);
 		//회원정보들을 저장할 member리스트를 선언하고 저장한다.
 		ArrayList member_list = new ArrayList();
 		//list는 객체 배열이므로 객체를 따로 저장해야한다.
 		if(application.getAttribute("member_list")!=null){
 			//멤버리스트에 add를 계속 해주면 list배열 안에 list배열이 생긴다.
 			member_list=(ArrayList)application.getAttribute("member_list");
 			member_list.add(member);
 			application.setAttribute("member_list", member_list);
 			System.out.println(application.getAttribute("member_list"));
 		}else{
 			member_list.add(member);
 			application.setAttribute("member_list", member_list);
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
                <td><%=userId %></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><%=password %></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><%=userName %></td>
            </tr>
            <tr>
                <td>사진</td>
                <td></td>
            </tr>
        </table>
</div>

</body>
</html>