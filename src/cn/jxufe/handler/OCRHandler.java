package cn.jxufe.handler;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.jxufe.ocr.OCR;
import cn.jxufe.ocr.impl.BaiDuOCR;

@WebServlet("/OCRHandler")
public class OCRHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String result;
       
    public OCRHandler() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ServletContext servletContext = this.getServletContext();
		String destFileStr = (String) servletContext.getAttribute("destFileStr");
		System.out.println("OCRHandler destFileStr:" + destFileStr);
		OCR ocr = new BaiDuOCR();
		result = ocr.getOCR(new File(destFileStr));
		System.out.println("识别结果:" + result);

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>Servlet获取识别后信息</title><head>");
		out.println("<body>");
		out.println("<center>");
		out.println("<font size=2");
		out.println("<p>"+result+"</p>");
		out.println("</center>");
		out.println("</body>");
		out.println("</html>");
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
