package cn.jxufe.utils;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GetResourceFromWF")
public class GetResourceFromWF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetResourceFromWF() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = request.getParameter("url");
		
		ServletContext servletContext = this.getServletContext();
		RequestDispatcher rd = servletContext.getRequestDispatcher("/WEB-INF" + url);
		rd.forward(request, response);
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
