package com.common.main.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.open.api.service.OpenApiService;
import com.common.session.MenuVO;
import com.common.session.SessionVO;
import com.common.session.UserVO;


@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	OpenApiService openApiService;
	
	@RequestMapping("/index.do")
	public String goIndex(HttpServletRequest request,Model model) {
		
		String view = request.getServletPath().substring(1,request.getServletPath().lastIndexOf("."));
		
		HttpSession session = request.getSession(true);
		
		// session check
		if (session.getAttribute("sessionVO") == null) {
			/*
			model.addAttribute("errMsg","로그인을 해주세요.");
			model.addAttribute("returnPage","/");
			model.addAttribute("returnParam","");
			model.addAttribute("returnType","");
			return "error";
			*/
			// TODO UserVO
	        UserVO userVO = new UserVO();
			//userVO.setId(userInfo.get("email").toString());
	        userVO.setId("testID"); // TODO
			userVO.setName("testNm"); // TODO
			
	        // TODO 메뉴 관리 어캐할거냐?
			List<MenuVO> menuList = new ArrayList();
			MenuVO menuVO = new MenuVO();
			menuVO.setIdx(1);
			menuVO.setTitle("Home");
			menuVO.setUrl("/main/index.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(2);
			menuVO.setTitle("유기동물 조회");
			menuVO.setUrl("/main/index2.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(3);
			menuVO.setTitle("보호중");
			menuVO.setUrl("/main/index3.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(4);
			menuVO.setTitle("찾아요");
			menuVO.setUrl("/main/index4.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(5);
			menuVO.setTitle("자유게시판");
			menuVO.setUrl("/main/index5.do");
			menuList.add(menuVO);
			
			SessionVO sessionVO = new SessionVO();
			sessionVO.setUserVO(userVO);
			sessionVO.setMenuIdx(1);
			sessionVO.setMenuList(menuList);
			
			session.setAttribute("sessionVO", sessionVO);
		}
		
		// session menu save
		SessionVO sessionVO = (SessionVO)session.getAttribute("sessionVO");
		sessionVO.setMenuIdx(1);
		session.setAttribute("sessionVO", sessionVO);
		
		// service
		Map<String, Object> searchJSON = new HashMap<String, Object>();
		model.addAttribute("sido",openApiService.OrganicAnimalsSearch("sido", searchJSON));
		
		return view;
	}
	@RequestMapping("/index2.do")
	public String goIndex2(HttpServletRequest request,Model model) {
		
		String view = request.getServletPath().substring(1,request.getServletPath().lastIndexOf("."));
		
		HttpSession session = request.getSession(true);
		
		// session check
		if (session.getAttribute("sessionVO") == null) {
			/*
			model.addAttribute("errMsg","로그인을 해주세요.");
			model.addAttribute("returnPage","/");
			model.addAttribute("returnParam","");
			model.addAttribute("returnType","");
			return "error";
			*/
			// TODO UserVO
	        UserVO userVO = new UserVO();
			//userVO.setId(userInfo.get("email").toString());
	        userVO.setId("testID"); // TODO
			userVO.setName("testNm"); // TODO
			
	        // TODO 메뉴 관리 어캐할거냐?
			List<MenuVO> menuList = new ArrayList();
			MenuVO menuVO = new MenuVO();
			menuVO.setIdx(1);
			menuVO.setTitle("Home");
			menuVO.setUrl("/main/index.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(2);
			menuVO.setTitle("유기동물 조회");
			menuVO.setUrl("/main/index2.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(3);
			menuVO.setTitle("보호중");
			menuVO.setUrl("/main/index3.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(4);
			menuVO.setTitle("찾아요");
			menuVO.setUrl("/main/index4.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(5);
			menuVO.setTitle("자유게시판");
			menuVO.setUrl("/main/index5.do");
			menuList.add(menuVO);
			
			SessionVO sessionVO = new SessionVO();
			sessionVO.setUserVO(userVO);
			sessionVO.setMenuIdx(1);
			sessionVO.setMenuList(menuList);
			
			session.setAttribute("sessionVO", sessionVO);
		}
		
		// session menu save
		SessionVO sessionVO = (SessionVO)session.getAttribute("sessionVO");
		sessionVO.setMenuIdx(2);
		session.setAttribute("sessionVO", sessionVO);
		
		// service
		Map<String, Object> searchJSON = new HashMap<String, Object>();
		model.addAttribute("sido",openApiService.OrganicAnimalsSearch("sido", searchJSON));
				
		return view;
	}
	
}
