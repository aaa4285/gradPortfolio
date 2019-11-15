package com.common.main.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.aws.service.AwsService;
import com.common.batch.FileUtils;
import com.common.batch.chartBatch;
import com.common.open.api.service.OpenApiService;
import com.common.util.CommonUtils;


@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	OpenApiService openApiService;
	
	@Autowired
	AwsService awsService;
	
	@Value("${aws.bucket.json.upload.path}")
	private String bucketJsonUploadPath;
	
	@Value("${aws.bucket.json.file.name}")
	private String fileNm;
	
	@RequestMapping("/index.do")
	public String goIndex(HttpServletRequest request,Model model) {
		
		String view = request.getServletPath().substring(1,request.getServletPath().lastIndexOf("."));
		
		CommonUtils.setSession(request, 1);
		/*
		try {
			Resource resource = awsService.getObject(bucketJsonUploadPath, fileNm);
			String jsonString = FileUtils.readFile(resource);
			model.addAttribute("chartData",jsonString);
		} catch (IOException e) {
			//errors.aws.file.not.find
			e.printStackTrace();
		}
		*/
		// service
		//	System.out.println(FileUtils.readFile(chartBatch.path+chartBatch.fileNm));
		//model.addAttribute("chartData",FileUtils.readFile(chartBatch.path+chartBatch.fileNm));
		Map<String, Object> searchJSON = new HashMap();
		searchJSON.put("pageNo",1);
		searchJSON.put("numOfRows",4);
		model.addAttribute("search", openApiService.OrganicAnimalsSearch("abandonmentPublic", searchJSON));
		return view;
	}
	@RequestMapping("/index2.do")
	public String goIndex2(HttpServletRequest request,Model model,@RequestBody(required = false) Map<String, Object> searchJSON) {
		
		String view = request.getServletPath().substring(1,request.getServletPath().lastIndexOf("."));
		
		CommonUtils.setSession(request, 2);
		
		// 시도 코드
		model.addAttribute("sido",openApiService.OrganicAnimalsSearch("sido", new HashMap<String, Object>()));
		return view;
	}
	
}
