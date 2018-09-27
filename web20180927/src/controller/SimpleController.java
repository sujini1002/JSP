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
		
		//��û �ľ�(�м�)
		String type = request.getParameter("type");
		//null,greeting,date �� �� �ϳ��� ��
		//*���� :  list, write, delete
		
		//���� ��ü ����
		Object resultObject = null;
		String viewPage = "/simpleView.jsp";
		
		if(type == null || type.equals("greeting")) {
			resultObject = "�ȳ��ϼ���";
			viewPage = "/greetingView.jsp";
		}else if(type.equals("date")){
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
