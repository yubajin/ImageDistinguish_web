package cn.jxufe.ocr.impl;

import java.io.File;
import java.util.HashMap;

import org.json.JSONObject;

import com.baidu.aip.ocr.AipOcr;

import cn.jxufe.ocr.OCR;

/**
 * 返回图片上识别的问题和选项
 */
public class BaiDuOCR implements OCR{
    private static final String APP_ID = "10686957";
    private static final String API_KEY = "lbysq1pHG7tHNXsGbzBl6XVU";
    private static final String SECRET_KEY = "YgfVD1mikkYoGn9MaPz9KjvV6ppLQcFA";
    private static final AipOcr CLIENT=new AipOcr(APP_ID, API_KEY, SECRET_KEY);
    public BaiDuOCR(){
        CLIENT.setConnectionTimeoutInMillis(4000);
        CLIENT.setSocketTimeoutInMillis(60000);
        System.out.println("欢迎您使用百度OCR进行文字识别");
    }
    @Override
    public String getOCR(File file) {
        Long start=System.currentTimeMillis();
        String path=file.getAbsolutePath();
        JSONObject res = CLIENT.basicGeneral(path, new HashMap<String, String>());
        String result=res.toString(2);
        System.out.println("百度文字识别耗时:" + ((System.currentTimeMillis())-start) + "ms");
        return result;
    }

    public static void main(String[] args) {
        OCR ocr=new BaiDuOCR();
        String path = "Photo\\test1.png";
//        String path = "C:\\Users\\Administrator\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\ImageDistinguish_web\\WEB-INF\\upload\\test1.png";
        String result=ocr.getOCR(new File(path));
        System.out.println("图片识别结果:\n" + result);
    }
}
