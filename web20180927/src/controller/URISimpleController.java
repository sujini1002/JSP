package controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class URISimpleController extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processsRequest(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processsRequest(request,response);
	}

	private void processsRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//��û �ľ�(�м�)
		//String type = request.getParameter("type");
		String type= request.getRequestURI();
		if(type.indexOf(request.getContextPath()) == 0) {
			type = type.substring(request.getContextPath().length());
		}
		//null,greeting,date �� �� �ϳ��� ��
		//*���� :  list, write, delete
		System.out.println(type);
		//���� ��ü ����
		Object resultObject = null;
		String viewPage = "/simpleView.jsp";
		
		if(type.equals("/greeting.do")) {
			resultObject = "�ȳ��ϼ���";
			viewPage = "/greetingView.jsp";
		}else if(type.equals("/date.do")){
			resultObject = new Date();
			viewPage = "/dateView.jsp";
		}else {
			resultObject = "Invalid Type";
		}
		//�Ŀ�, �����ӿ�ũ�� ó�� �� ��
		//���� �����͸� ���尴ü(request,session)�� �Ӽ��� ���� : ���� ,����
		request.setAttribute("result", resultObject);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
