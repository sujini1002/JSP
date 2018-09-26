<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
        *{padding: 0;margin: 0};
        div{margin: auto;}
        h1{text-align: center;margin-top:20px}
        #wrapper{width:1300px;margin:auto}
        #header{width: 1000px;height: 100px;margin:auto}
        #nav_bar{width: 1000px;height: 70px;text-align:center;margin:auto}
        #content{width: 1000px;height:  1000px;margin:auto}
        #content_left{width: 40%;float:left;margin-left:50px}
        #content_right{width: 40%;float: right}
    </style>
</head>
<body>
<div id="wrapper">
	<div id="header">
        <h1>include 지시어 테스트</h1>
    </div>
    <hr>
    <div id="nav_bar">
        <%@ include file ="/common/nav_bar.jsp" %>
    </div>
    <div id="content">
        <div id="content_left">
        <%@ include file ="/common/content_left.jsp" %>
        </div>
        <div id="content_right">
        <%@ include file ="/common/content_right.jsp" %>
        </div>
    </div>
</div>
</body>
</html>