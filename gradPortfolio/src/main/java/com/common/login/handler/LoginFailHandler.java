package com.common.login.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class LoginFailHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		//로그인 정보 저장
        String userName = request.getParameter("user_id");
        String password = request.getParameter("password");

        request.setAttribute("user_id", userName);
        request.setAttribute("password", password);

//      에러 메세지 저장
//      String errorMsg = exception.getMessage();
//      req.setAttribute(errormsgname, errorMsg);

        String errorMsg = "로그인실패";
        request.setAttribute("ERRORMSG", errorMsg);
        
        request.getRequestDispatcher("/login").forward(request, response);
    }

}
