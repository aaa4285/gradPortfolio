package com.common.main.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.aws.service.AwsService;
import com.common.batch.FileUtils;
import com.common.board.domain.BoardVO;
import com.common.board.paging.Criteria;
import com.common.board.service.BoardService;
import com.common.board.service.ProBoardService;
import com.common.open.api.service.OpenApiService;
import com.common.util.CommonUtils;


@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	OpenApiService openApiService;
	
	@Autowired
	AwsService awsService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	ProBoardService proBoardService;
	
	@Value("${aws.bucket.json.upload.path}")
	private String bucketJsonUploadPath;
	
	@Value("${aws.bucket.json.file.name}")
	private String fileNm;
	
	@RequestMapping("/index.do")
	public String goIndex(HttpServletRequest request,Model model) throws Exception {
		
		String view = request.getServletPath().substring(1,request.getServletPath().lastIndexOf("."));
		
		CommonUtils.setSession(request, 1);
		
		// 게시판 미리보기 조회
		Criteria criteria = new Criteria();
		criteria.setPerPageNum(4);
		
        List<BoardVO> list = boardService.boardList(criteria);
        model.addAttribute("list", list);
        
        List<BoardVO> list2 = proBoardService.boardList(criteria);
        model.addAttribute("list2", list2);

		return view;
	}
	
	@RequestMapping("/index2.do")
	public String goIndex2(HttpServletRequest request,Model model,@RequestBody(required = false) Map<String, Object> searchJSON) {
		
		String view = request.getServletPath().substring(1,request.getServletPath().lastIndexOf("."));
		
		CommonUtils.setSession(request, 3);
		
		// 시도 코드
		model.addAttribute("sido",openApiService.OrganicAnimalsSearch("sido", new HashMap<String, Object>()));
		return view;
	}
	
	@RequestMapping("/about.do")
	public String goAbout(HttpServletRequest request,Model model,@RequestBody(required = false) Map<String, Object> searchJSON) {
		
		String view = request.getServletPath().substring(1,request.getServletPath().lastIndexOf("."));
		
		CommonUtils.setSession(request, 2);
		
		// 차트 데이터
		try {
			Resource resource = awsService.getObject(bucketJsonUploadPath, fileNm);
			String jsonString = FileUtils.readFile(resource);
			System.out.println(jsonString);
			int dogCnt = 0;
			int catCnt = 0;
			int etcCnt = 0;
			
			try {
				for (String str : jsonString.split(";\n")) {
					String[] arr = str.split("=");
					if ("var dogCnt".equals(arr[0])) {
						dogCnt = Integer.parseInt(arr[1]);
					} else if ("var catCnt".equals(arr[0])) {
						catCnt = Integer.parseInt(arr[1]);
					} else if ("var etcCnt".equals(arr[0])) {
						etcCnt = Integer.parseInt(arr[1]);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			model.addAttribute("dogCnt",dogCnt);
			model.addAttribute("catCnt",catCnt);
			model.addAttribute("etcCnt",etcCnt);
			model.addAttribute("totCnt",dogCnt+catCnt+etcCnt);
			model.addAttribute("chartData",jsonString);
		} catch (IOException e) {
			//errors.aws.file.not.find
			e.printStackTrace();
		}
		
		return view;
	}
	
}
