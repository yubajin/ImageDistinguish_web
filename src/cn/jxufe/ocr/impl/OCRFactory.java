package cn.jxufe.ocr.impl;

import cn.jxufe.ocr.OCR;

public class OCRFactory {
    public OCR getOcr(int choice){
        switch (choice){
            case 1:{
                return new TessOCR();
            }
            case 2:{
                return new BaiDuOCR();
            }
            default:{
                return new TessOCR();
            }
        }

    }
}
