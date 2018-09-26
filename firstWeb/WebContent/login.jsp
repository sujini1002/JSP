<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList" %>
   <%@ page import="firstWeb.memberInfo" %>
    <% 
    	request.setCharacterEncoding("utf-8");
    	String id = request.getParameter("userId");
    	String pw = request.getParameter("password");
    	
    	ArrayList list = (ArrayList)application.getAttribute("member_list");
    	
    	for(int i=0;i<list.size();i++){
    		memberInfo member = (memberInfo)list.get(i);//list안에는 객체가 있는 메모리 주소가 저장되어있다.
    		System.out.println(member.getUserId());
       		System.out.println(member.getUserPw());
    		if(member.getUserId().equals(id)&&member.getUserPw().equals(pw) ){
    			//세션에 객체를 저장해야 한다.하지만 비밀번호는 개인정보이므로 세션에는 저장하지 않아야 한다.
    			memberInfo tmp = new memberInfo(member.getUserId(),member.getUserPw(),member.getUserName());
    			tmp.setUserPw("");//list에 저장되어 있는 비밀번호도 초기화 된다. 
    			request.getSession(false).setAttribute("loginInfo",tmp);
    			
 /*     	    request.getSession(false).setAttribute("userId", id);
        		request.getSession(false).setAttribute("userName", member.get.UserName());    */ 
        		response.sendRedirect("mypage.jsp");//세션을 이용하여 로그인 되었을 때만 처리하도록 설정
        		break;
    		}
    	}
    	//회원리스트에 아이디가 있을 때에만 처리되는 문장
    	
    	
    %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
<%@ include file="/common/header.jsp" %>
<div id="contents">
<h2>로그인</h2>
<hr>
<h1>아이디 또는 비밀번호가 틀립니다. 확인해주세요.</h1>
<h3><a href="loginForm.jsp">다시로그인하기</a></h3>

</div>
</body>
</html>