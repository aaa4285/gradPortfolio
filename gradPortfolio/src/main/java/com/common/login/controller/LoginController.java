package com.common.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.common.basic.login.entity.BasicMemberDto;
import com.common.basic.login.entity.BasicUserService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class LoginController {
	
	private BasicUserService basicUserService;
	
	@RequestMapping("/login")
	public String login() {
		return "login/login";
	}
	
	@RequestMapping("/example")
	public String example() {
		return "example/layerExa";
	}
	
	@RequestMapping("/sign")
	public String sign() {
		return "login/sign";
	}
	
	@RequestMapping("/")
	public String main() {
		return "redirect:/main/index.do";
	}
	
	@RequestMapping("/login/signUp")
	public String signUp(@ModelAttribute BasicMemberDto memberDto, Model model) {
		basicUserService.joinUser(memberDto);
		
		model.addAttribute("signUp", "success");
		
		return "login/login";
	}
	
}
