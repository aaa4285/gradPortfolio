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
	        // TODO 메뉴 관리 어캐할거냐?
			List<MenuVO> menuList = new ArrayList();
			MenuVO menuVO = new MenuVO();
			
			menuVO.setIdx(1);
			menuVO.setTitle("HOME");
			menuVO.setUrl("/main/index.do");
			menuList.add(menuVO);
			
			menuVO = new MenuVO();
			menuVO.setIdx(2);
			menuVO.setTitle("소개");
			menuVO.setUrl("/main/about.do");
			menuList.add(menuVO);
			
			menuVO = new MenuVO();
			menuVO.setIdx(3);
			menuVO.setTitle("유기동물 조회");
			menuVO.setUrl("/main/index2.do");
			menuList.add(menuVO);
			
			menuVO = new MenuVO();
			menuVO.setIdx(4);
			menuVO.setTitle("실종동물 찾기");
			menuVO.setUrl("/board/list");
			menuList.add(menuVO);
			
			menuVO = new MenuVO();
			menuVO.setIdx(5);
			menuVO.setTitle("유기동물 보호중");
			menuVO.setUrl("/proBoard/list");
			menuList.add(menuVO);
			
			sessionVO = new SessionVO();
			sessionVO.setMenuList(menuList);
		}
		sessionVO.setMenuIdx(idx);
		session.setAttribute("sessionVO", sessionVO);
	}
}
