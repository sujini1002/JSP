<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="openProject.memberInfo" %>
    <%@ page import="openProject.loginForm" %>
   	<jsp:useBean id="loginMember" class="openProject.memberInfo" scope="page"/>
   	<jsp:useBean id="members" class="java.util.ArrayList" scope="application"/>
   	<jsp:useBean id="sessionMember" class="openProject.loginForm" scope="session"/>
   	<% response.setCharacterEncoding("utf-8"); %>
   	<%
   		String uid = request.getParameter("userId");
   		String upw = request.getParameter("userPw");
   		Cookie[] cookies = request.getCookies();
   		for(int j=0;j<members.size();j++){
   		loginMember = (memberInfo)members.get(j);
   		
   		if(loginMember.getUserId().equals(uid)&& loginMember.getUserPw().equals(upw)){
   			if(request.getParameter("id_save")==null){
	    		if(cookies!=null && cookies.length>0){
	    			for(int i =0;i<cookies.length;i++){
	    				if(cookies[i].getName().equals("id")){
	    					Cookie cookie = new Cookie("id","");
	    					cookie.setMaxAge(0);
	    					response.addCookie(cookie);
	    				}
	    			}
	    		}
	    	}else{
	    		if(cookies!=null && cookies.length>0){
	    			for(int i=0;i<cookies.length;i++){
	    				if(cookies[i].getName().equals(uid)){
	    					Cookie cookie = new Cookie("id", uid);
	    					response.addCookie(cookie);
	    				}else{
	    					Cookie cookie = new Cookie("id",uid);
	    					response.addCookie(cookie);
	    				}
	    			}
	    		}
	    	}
   				 loginForm tmp = new loginForm(loginMember.getUserId(),loginMember.getUserName(),loginMember.getUserImg());
				 request.getSession(false).setAttribute("sessionMember", tmp);
			   	 response.sendRedirect("mypage.jsp");
			   	 break;
   		}else{
   			if(cookies!=null && cookies.length>0){
    			for(int i=0;i<cookies.length;i++){
    				if(cookies[i].getName().equals("id")){
    					Cookie cookie = new Cookie("id","");
    					cookie.setMaxAge(0);
    					response.addCookie(cookie);
    				}
    			}
    		}
   			
   		
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
<%
  }
 }%>
