package com.common.login.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.common.login.basic.BasicMemberDto;
import com.common.login.service.BasicUserService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class LoginController {
	
	private BasicUserService basicUserService;
	
	private MessageSourceAccessor message;
	
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

		return "login/signSucess";
	}
	
	@RequestMapping("/sign/duplicateCheck")
	public @ResponseBody Map<String, Object> signUp(@ModelAttribute BasicMemberDto memberDto) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(memberDto);
		boolean isDuplicateCheck = basicUserService.isDuplicateCheck(memberDto.getEmail());
		boolean result = false;
		String msg = "";
		
		System.out.println("isDuplicateCheck:" + isDuplicateCheck);
		
		if (isDuplicateCheck) {
			result = true;
		} else {
			result = false;
			msg = message.getMessage("errors.login.overlap");
		}
		
		resultMap.put("result", result);
		resultMap.put("msg", msg);
		
		return resultMap;
	}
	
	
	
}
