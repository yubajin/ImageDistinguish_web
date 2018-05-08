package cn.jxufe.test;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.Format;
import java.util.Date;

public class MyTest {
	
	public static void main(String[] args) {
		LogFile();
	}
	public static void LogFile() {
		File logDir = new File("E:/logfile");
		String fileAbsolutePath = logDir.getAbsolutePath();
		if(!logDir.exists()) {
			logDir.mkdir();
		}
		
		File logfile = new File(fileAbsolutePath+"/log.txt");
		FileWriter fw = null;
		BufferedWriter writer = null;
		
		try {
			fw = new FileWriter(logfile,true);
			writer = new BufferedWriter(fw);
			

			String ip = "10.16.24eef.0";
			String data = new Date().toString();
			String img_url = "C:\\Userssvgersnyjhbgfvdvgre\\Administrator\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\ImageDistinguish_web\\upload\\2018-05-08\\14\\0\\47c7c41c-c126-48fc-a84f-84ffe630e5c6_test1 - 副本.png";
			
			
			String format_ip = String.format("%-10s", ip);
			String format_data = String.format("%-20s", data);
			String format_img_url = String.format("%-200s", img_url);
			
			
			writer.write(format_ip+format_data+format_img_url);
			writer.newLine();
			writer.newLine();
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				writer.close();
				fw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
