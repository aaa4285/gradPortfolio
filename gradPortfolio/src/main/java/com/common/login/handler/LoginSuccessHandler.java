package com.common.login.handler;

import java.awt.print.Printable;
import java.io.IOException;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import com.common.constantes.BaseConstantes;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();


	@Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
		ObjectMapper mapper = new ObjectMapper();

		System.out.println(mapper.writeValueAsString(authentication));
		
		Map<String, Object> principalMap = mapper.convertValue(authentication.getPrincipal(), Map.class);
		
		Map<String, Object> sessionMap = new HashMap<String, Object>();
		
		// 소셜 로그인
		if (StringUtils.isEmpty(principalMap.get("displayName"))) {
			Map<String, Object> sosialMap = mapper.convertValue(principalMap.get("social"), Map.class);
			sessionMap.putAll(sosialMap);
			sosialMap.put("id", principalMap.get("id"));
		} else {
			sessionMap.putAll(principalMap);
		}
		
		// 비밀번호 삭제
		sessionMap.remove("password");
		
		HttpSession session = request.getSession();
		session.setAttribute(BaseConstantes.USER_SESSION_ID, sessionMap);
		
		resultRedirectStrategy(request, response, authentication);
    }


	protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		if (savedRequest != null) {
			String targetUrl = savedRequest.getRedirectUrl();
			redirectStratgy.sendRedirect(request, response, targetUrl);
		} else {
			redirectStratgy.sendRedirect(request, response, "/");
		}
	}
}