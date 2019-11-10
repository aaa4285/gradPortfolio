package com.common.login.controller;

import java.io.IOException;
import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	
	@RequestMapping("/login")
	public String login() {
		AuthenticationTrustResolver trustResolver = new AuthenticationTrustResolverImpl();
		if (trustResolver.isAnonymous(SecurityContextHolder.getContext().getAuthentication())) {
			return "login/login";
		} else {
			return "redirect:/main/index.do";
		}
	}
	
	@RequestMapping("/")
	public String main() {
		return "redirect:/main/index.do";
	}
	
}
