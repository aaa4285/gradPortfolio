package com.common.login.facebook;

import org.springframework.security.oauth2.common.OAuth2AccessToken;

import lombok.Getter;

@Getter
public class FacebookUserDetails {
	
    public Picture picture;
    private String id;
    private String name;
    private String email;
    private long expiration;
    private String access_token;

    public void setAccessToken(OAuth2AccessToken accessToken) {
        this.access_token = accessToken.getValue();
        this.expiration = accessToken.getExpiration().getTime();
    }

    public String getImageUrl() {
        return getPicture().getData().getUrl();
    }

    @Getter
    public static class Picture {
    	private Data data;
    	
    	@Getter
        public static class Data {
    		
            private String url;
    		
            private String height;
        }
    }

   

}
