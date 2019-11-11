package com.common.batch;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class test {
	public static void main(String[] args) {
		createJson("가나다");
		
	}
	
	public static void createJson(String str) {
		String path = "/data/batch/chart/";
		String fileNm = "chart_data.json";
		
		File file = new File(path);
		if (!file.exists()) {
			if (!file.mkdirs()) {
				System.err.println("폴더 생성 실패!!");
			}
		}
		
		file = new File(path+fileNm);
		FileWriter writer = null;
        BufferedWriter bWriter = null;
        
        try {
            writer = new FileWriter(file, true);
            bWriter = new BufferedWriter(writer);
            
            bWriter.write(str);
            bWriter.flush();
            
            System.out.println("DONE :: " + file.getAbsolutePath());
        } catch(IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if(bWriter != null) bWriter.close();
                if(writer != null) writer.close();
            } catch(IOException e) {
                e.printStackTrace();
            }
        }
	}
}
