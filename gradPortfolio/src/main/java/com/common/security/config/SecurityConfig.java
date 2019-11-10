package com.common.security.config;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;

import org.springframework.boot.autoconfigure.security.oauth2.resource.UserInfoTokenServices;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.oauth2.client.OAuth2ClientContext;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.client.filter.OAuth2ClientAuthenticationProcessingFilter;
import org.springframework.security.oauth2.client.filter.OAuth2ClientContextFilter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableOAuth2Client;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.filter.CompositeFilter;

import com.common.login.facebook.FacebookOAuth2ClientAuthenticationProcessingFilter;
import com.common.login.google.GoogleOAuth2ClientAuthenticationProcessingFilter;
import com.common.login.handler.LoginSuccessHandler;
import com.common.login.service.SocialService;

import lombok.AllArgsConstructor;

@EnableWebSecurity
@EnableOAuth2Client
@AllArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final OAuth2ClientContext oauth2ClientContext;
    private final SocialService socialService;


    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // @formatter:off

        http.csrf().disable();
        http.antMatcher("/**").authorizeRequests()
        		.antMatchers("/board/**").authenticated()
        		.antMatchers("/**").permitAll()
				.and().exceptionHandling()
				.authenticationEntryPoint(new LoginUrlAuthenticationEntryPoint("/login")).and()
				.addFilterBefore(ssoFilter(), BasicAuthenticationFilter.class);

		// logout
		http.logout()
                .invalidateHttpSession(true)
                .clearAuthentication(true)
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                    .logoutSuccessUrl("/")
                .permitAll();
		// @formatter:on
    }

    @Bean
    public FilterRegistrationBean oauth2ClientFilterRegistration(OAuth2ClientContextFilter filter) {
        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setFilter(filter);
        registration.setOrder(-100);
        return registration;
    }

    @Bean
    @ConfigurationProperties("facebook")
    public ClientResources facebook() {
        return new ClientResources();
    }

    @Bean
    @ConfigurationProperties("google")
    public ClientResources google() {
        return new ClientResources();
    }

    private Filter ssoFilter() {
        CompositeFilter filter = new CompositeFilter();
        List<Filter> filters = new ArrayList<>();

        filters.add(ssoFilter(facebook(), new FacebookOAuth2ClientAuthenticationProcessingFilter(socialService))); //  이전에 등록했던 OAuth 리다이렉트 URL 
        filters.add(ssoFilter(google(), new GoogleOAuth2ClientAuthenticationProcessingFilter(socialService)));
        filter.setFilters(filters);
        return filter;
    }

    private Filter ssoFilter(ClientResources client, OAuth2ClientAuthenticationProcessingFilter filter) {
    	
        OAuth2RestTemplate restTemplate = new OAuth2RestTemplate(client.getClient(), oauth2ClientContext);
        UserInfoTokenServices tokenServices = new UserInfoTokenServices(client.getResource().getUserInfoUri(), client.getClient().getClientId());
        tokenServices.setRestTemplate(restTemplate);
        
        filter.setRestTemplate(restTemplate);
        filter.setTokenServices(tokenServices);
        filter.setAuthenticationSuccessHandler(new LoginSuccessHandler());
        return filter;
    }
}