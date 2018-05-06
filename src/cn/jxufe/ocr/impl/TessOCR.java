package cn.jxufe.ocr.impl;

import java.io.File;

import cn.jxufe.ocr.OCR;
import net.sourceforge.tess4j.ITesseract;
import net.sourceforge.tess4j.Tesseract;
import net.sourceforge.tess4j.TesseractException;
import net.sourceforge.tess4j.util.LoadLibs;

public class TessOCR implements OCR {
    private ITesseract instance;

    TessOCR() {
        instance = new Tesseract();
        File tessDataFolder = LoadLibs.extractTessResources("tessdata");
        instance.setLanguage("chi_sim");
        //Set the tessdata path
        instance.setDatapath(tessDataFolder.getAbsolutePath());
        System.out.println("欢迎您使用TessOCR进行文字识别");
    }

    @Override
    public String getOCR(File file) {
        Long start = System.currentTimeMillis();
        String result = null;
        try {
            result = instance.doOCR(file);
        } catch (TesseractException e) {
            System.err.println("tessOCR提取图片文字信息失败");
        }
        float time=(System.currentTimeMillis()-start)/(1000f);
        System.out.println("tessOCR提取信息成功，耗时："+time+"s");
        return result;
    }

    public static void main(String[] args) {
        String path = "Photo\\test.png";
        TessOCR tessOCR = new TessOCR();
        System.out.println(tessOCR.getOCR(new File(path)));
    }
}
