package com.common.session;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SessionVO {
	
	boolean isLogin;
	Date time;
	UserVO userVO;
	List<MenuVO> menuList;
	int menuIdx;
	
	public int getMenuIdx() {
		return menuIdx;
	}
	public void setMenuIdx(int menuIdx) {
		this.menuIdx = menuIdx;
	}
	public List<MenuVO> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<MenuVO> menuList) {
		this.menuList = menuList;
	}
	public boolean isLogin() {
		Map map = new HashMap();
		return isLogin;
	}
	public void setLogin(boolean isLogin) {
		this.isLogin = isLogin;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public UserVO getUserVO() {
		return userVO;
	}
	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}

	
}
