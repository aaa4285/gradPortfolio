package com.common.login.facebook;

import java.io.IOException;
import java.security.Principal;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import com.common.login.service.SocialService;

public class FacebookLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	 private ObjectMapper mapper = new ObjectMapper();
	 private final SocialService socialService;
	 
	 public FacebookLoginSuccessHandler(SocialService socialService) {
		this.socialService = socialService;
	}
	 
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		Enumeration params = request.getParameterNames();
		
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +request.getParameter(name));
		}
		
		 Map<String, Object> authenticationMap = mapper.convertValue(authentication, Map.class);
		 Map<String, Object> details = (Map) authenticationMap.get("details");
		 Map<String, Object> userDetails = (Map<String, Object>) authenticationMap.get("userAuthentication"); 
/*		 	
        final FacebookUserDetails userDetails = mapper.convertValue(userAuthentication, FacebookUserDetails.class);
        userDetails.setAccessToken((OAuth2AccessToken) details.get("tokenValue"));
        final UserConnection userConnection = UserConnection.valueOf(userDetails);
        final UsernamePasswordAuthenticationToken authenticationToken = socialService.doAuthentication(userConnection);*/
        
	}

}
