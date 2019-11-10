package com.common.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	/*
	@RequestMapping("/login")
	public String login() {
		AuthenticationTrustResolver trustResolver = new AuthenticationTrustResolverImpl();
		if (trustResolver.isAnonymous(SecurityContextHolder.getContext().getAuthentication())) {
			return "login/login";
		} else {
			return "redirect:/main/index.do";
		}
	}
	*/
	
	
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
	
}
