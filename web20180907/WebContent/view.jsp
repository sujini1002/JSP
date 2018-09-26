<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1.사용자가 요청한 데이터 받기
	//2. 분석(java코드로 분석 할 수 있음)
	//3. 처리(service()-DAO에서  vo,dto,beans형태로 반환) 하여 결과 산출 후 기본객체 속성으로 저장(응답페이지에 출력할 데이터 보내기)
	//4. 응답 페이지 지정(어떤 페이지(jsp)를 응답 템플릿으로 사용할지 결정-사용자의 요청에 따라서 응답페이지가 다를 수 있다(여러요청페이지를 하나의 jsp로
    //			요청을 처리 할  수 있다.))
	//5. 포워딩(다른 페이지로 전달)
	
	//1.사용자 요청 데이터 받기
	String code = request.getParameter("code");
	String viewPage ="";
//2. 분석
	 if(code.equals("A")){
		 //결과데이터
		 Date date = new Date();
		//3. 처리 하여 결과 산출 후 기본객체 속성으로 저장
		 request.setAttribute("result", date);
		//4. 응답 페이지 지정
		 viewPage = "view/A.jsp";
	 }
	//2. 분석
	 else if(code.equals("B")){
		//3. 처리 하여 결과 산출 후 기본객체 속성으로 저장
		 String str = "Hello~";
		 request.setAttribute("result", str);
		//4. 응답 페이지 지정
		 viewPage = "view/B.jsp";
	 }
	//2. 분석
	 else if(code.equals("C")){
		//3. 처리 하여 결과 산출 후 기본객체 속성으로 저장
		 int age = 12;
		request.setAttribute("result", age);
		//4. 응답 페이지 지정
		 viewPage = "view/C.jsp";
	 }
%>
<%--5. 포워딩(다른 페이지로 전달) --%>
<jsp:forward page="<%= viewPage %>"/>