package com.common.batch;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

public class FileUtils {
	public static String readFile(String filePath) {
		String fileStr = "";
		try {
			FileInputStream fileInputStream = new FileInputStream(filePath);
			InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream, "UTF-8");
			BufferedReader br = new BufferedReader(inputStreamReader);
			String sCurrentLine; 
			while ((sCurrentLine = br.readLine()) != null) { fileStr+=sCurrentLine; }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return fileStr;
	}
	
	public static void writeFile(String str,String path,String fileNm) throws Exception {
		
		File file = new File(path);
		if (!file.exists()) {
			if (!file.mkdirs()) {
				throw new Exception("폴더생성 실패.");
			}
		}
		
		file = new File(path+fileNm);
		FileWriter writer = null;
        BufferedWriter bWriter = null;
        
        try {
            writer = new FileWriter(file, false);
            bWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file, false), "UTF-8"));
            
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
