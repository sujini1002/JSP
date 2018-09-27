package controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class SimpleController extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processsRequest(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processsRequest(request,response);
	}

	private void processsRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//요청 파악(분석)
		String type = request.getParameter("type");
		//null,greeting,date 셋 중 하나의 값
		//*방명록 :  list, write, delete
		
		//응답 객체 생성
		Object resultObject = null;
		String viewPage = "/simpleView.jsp";
		
		if(type == null || type.equals("greeting")) {
			resultObject = "안녕하세요";
			viewPage = "/greetingView.jsp";
		}else if(type.equals("date")){
			resultObject = new Date();
			viewPage = "/dateView.jsp";
		}else {
			resultObject = "Invalid Type";
		}
		//후에, 프레임워크가 처리 할 일
		//응답 데이터를 내장객체(request,session)의 속성에 저장 : 공유 ,전달
		request.setAttribute("result", resultObject);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
