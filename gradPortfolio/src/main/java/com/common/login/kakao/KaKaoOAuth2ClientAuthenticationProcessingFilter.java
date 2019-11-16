package com.common.login.kakao;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.client.filter.OAuth2ClientAuthenticationProcessingFilter;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;

import com.common.login.service.SocialService;
import com.common.login.social.entity.UserConnection;

public class KaKaoOAuth2ClientAuthenticationProcessingFilter extends OAuth2ClientAuthenticationProcessingFilter{

    private ObjectMapper mapper = new ObjectMapper();
    private final SocialService socialService;

    public KaKaoOAuth2ClientAuthenticationProcessingFilter(SocialService socialService) {
        super("/login/kakao");
        this.socialService = socialService;
        mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    }
    
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
    		throws AuthenticationException, IOException{
    	try {
			return super.attemptAuthentication(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return null;
    }
    
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authResult) throws IOException, ServletException {

        final OAuth2AccessToken accessToken = restTemplate.getAccessToken();
        final OAuth2Authentication auth = (OAuth2Authentication) authResult;
        final Object details = auth.getUserAuthentication().getDetails();
        
        final KaKaoUserDetails userDetails = mapper.convertValue(details, KaKaoUserDetails.class);
        
        userDetails.setAccessToken(accessToken);
        
        final UserConnection userConnection = UserConnection.valueOf(userDetails);
        final UsernamePasswordAuthenticationToken authenticationToken = socialService.doAuthentication(userConnection);
        
        super.successfulAuthentication(request, response, chain, authenticationToken);
    }
    
}
