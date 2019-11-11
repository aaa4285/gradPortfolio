package com.common.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.batch.FileUtils;
import com.common.batch.chartBatch;
import com.common.open.api.service.OpenApiService;
import com.common.util.CommonUtils;


@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	OpenApiService openApiService;
	
	@RequestMapping("/index.do")
	public String goIndex(HttpServletRequest request,Model model) {
		
		String view = request.getServletPath().substring(1,request.getServletPath().lastIndexOf("."));
		
		CommonUtils.setSession(request, 1);
		
		// service
		System.out.println(FileUtils.readFile(chartBatch.path+chartBatch.fileNm));
		model.addAttribute("chartData",FileUtils.readFile(chartBatch.path+chartBatch.fileNm));
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
