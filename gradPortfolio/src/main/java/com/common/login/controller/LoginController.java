package com.common.login.controller;

import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	
	@RequestMapping("/login")
	public String welcome() {
		AuthenticationTrustResolver trustResolver = new AuthenticationTrustResolverImpl();
		if (trustResolver.isAnonymous(SecurityContextHolder.getContext().getAuthentication())) {
			return "login";
		} else {
			return "redirect:/main/index.do";
		}
	}
	
	/*
	@RequestMapping("/login/kakaoa")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session) {
		System.out.println("teststs");
		String access_Token = kakaoApi.getAccessToken(code);
	    HashMap<String, Object> userInfo = kakaoApi.getUserInfo(access_Token);
	    System.out.println("login Controller : " + userInfo);
	    
	    //    클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
	    if (userInfo.get("id") != null) {
	    	
	        //session.setAttribute("userId", userInfo.get("email"));
	        session.setAttribute("access_Token", access_Token);
	        session.setAttribute("access_Token", access_Token);
	        
	        // TODO UserVO
	        UserVO userVO = new UserVO();
			//userVO.setId(userInfo.get("email").toString());
	        userVO.setId(userInfo.get("id").toString()); // TODO
			userVO.setName(userInfo.get("nickname").toString()); // TODO
			
	        // TODO 메뉴 관리 어캐할거냐?
			List m = new ArrayList();
			Map map = new HashMap();
			map.put("url", "/main/index.do");
			map.put("label", "Home");
			map.put("idx", 0);
			m.add(map);
			map = new HashMap();
			map.put("url", "/main/index2.do");
			map.put("label", "유기동물 조회");
			map.put("idx", 1);
			m.add(map);
			map = new HashMap();
			map.put("url", "/main/index3.do");
			map.put("label", "보호중");
			map.put("idx", 2);
			m.add(map);
			map = new HashMap();
			map.put("url", "/main/index4.do");
			map.put("label", "찾아요");
			map.put("idx", 3);
			m.add(map);
			map = new HashMap();
			map.put("url", "/main/index5.do");
			map.put("label", "자유게시판");
			map.put("idx", 4);
			m.add(map);
			
			MenuVO menuVO = new MenuVO();
			menuVO.setList(m);
			
			SessionVO sessionVO = new SessionVO();
			sessionVO.setMenuVO(menuVO);
			sessionVO.setUserVO(userVO);
			sessionVO.setMenuUrl("/main/index.do");
			
			session.setAttribute("sessionVO", sessionVO);
	    }
		return "redirect:/main/index.do";
	}
	*/

}
