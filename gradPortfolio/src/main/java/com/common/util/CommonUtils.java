package com.common.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.session.MenuVO;
import com.common.session.SessionVO;
import com.common.session.UserVO;

public class CommonUtils {
	public static void setSession(HttpServletRequest request) {
		setSession(request,1);
	}
	public static void setSession(HttpServletRequest request,int idx) {
		HttpSession session = request.getSession(true);
		SessionVO sessionVO = (SessionVO)session.getAttribute("sessionVO");
		// session check
		if (session.getAttribute("sessionVO") == null) {
			// TODO UserVO
	        UserVO userVO = new UserVO();
	        userVO.setId("testID"); // TODO
			userVO.setName("testNm"); // TODO
			
	        // TODO 메뉴 관리 어캐할거냐?
			List<MenuVO> menuList = new ArrayList();
			MenuVO menuVO = new MenuVO();
			menuVO.setIdx(1);
			menuVO.setTitle("HOME");
			menuVO.setUrl("/main/index.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(2);
			menuVO.setTitle("FIND PAT");
			menuVO.setUrl("/main/index2.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(3);
			menuVO.setTitle("HELP FIND");
			menuVO.setUrl("/main/index3.do");
			menuList.add(menuVO);
			menuVO = new MenuVO();
			menuVO.setIdx(5);
			menuVO.setTitle("FREE BORD");
			menuVO.setUrl("/board/list");
			menuList.add(menuVO);
			sessionVO = new SessionVO();
			sessionVO.setUserVO(userVO);
			sessionVO.setMenuList(menuList);
		}
		sessionVO.setMenuIdx(idx);
		session.setAttribute("sessionVO", sessionVO);
	}
}
