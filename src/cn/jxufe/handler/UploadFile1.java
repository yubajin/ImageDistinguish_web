package cn.jxufe.handler;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/uploadfile1")
@MultipartConfig
public class UploadFile1 extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	public UploadFile1() {
		super();
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		System.out.println("访问ip为:" + request.getRemoteAddr());
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=utf-8");
		
//		List<Part> parts = (List<Part>) request.getParts();// 获取所有上传的文件数据
		
		Part part = request.getPart("file");//		<input type="file" id = "myfile1" name="myfile"><br>
		String header = part.getHeader("Content-Disposition");// 获取文件信息头
		String fileName = makeFileName(getFileName(header));// 获取文件名并且用uuid算法防止文件覆盖
		
		String savePath = request.getServletContext().getRealPath("/WEB-INF/upload");// 获取项目下的 /WEB-INF/upload 的绝对路径
		part.write(savePath + File.separator + fileName);// 写入

		File destFile = new File(savePath + File.separator + fileName);
		String destFileStr = destFile.toString();
		System.out.println("UploadFile1 destFileStr:" + destFileStr);
		
		ServletContext servletContext = this.getServletContext();
		servletContext.setAttribute("destFileStr", destFileStr);
		
		RequestDispatcher rd = servletContext.getRequestDispatcher("/OCRHandler");
		rd.forward(request, response);
		
	}
	
	/**
	 * 根据请求头解析出文件名 请求头的格式：
	 * 火狐和google浏览器下：form-data; name="file"; filename="snmp4j--api.zip" 
	 * IE浏览器下：form-data; name="file"; filename="E:\snmp4j--api.zip"
	 * 
	 * @param header
	 *            请求头
	 * @return 文件名
	 */
	private String getFileName(String header) {
	    String[] tempArr1 = header.split(";");
	    String[] tempArr2 = tempArr1[2].split("=");
	    String fileName = tempArr2[1].substring(tempArr2[1].lastIndexOf("\\") + 1).replaceAll("\"", "");
	    return fileName;
	}
	
	// filename = "上传的文件名.jpg";
	private String makeFileName(String filename) {
	    return UUID.randomUUID().toString() + "_" + filename;
	}
	
}

