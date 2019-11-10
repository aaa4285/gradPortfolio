package com.common.login.kakao;

import org.springframework.security.oauth2.common.OAuth2AccessToken;

import lombok.Getter;

@Getter
public class KaKaoUserDetails {
	
    public KakaoAccount kakao_account;
    private String id;
    private long expiration;
    private String access_token;

    public void setAccessToken(OAuth2AccessToken accessToken) {
        this.access_token = accessToken.getValue();
        this.expiration = accessToken.getExpiration().getTime();
    }

    public String getImageUrl() {
        return getKakao_account().getProfile().getProfile_image_url();
    }
    
    public String getEmail() {
        return getKakao_account().getEmail();
    }
    
    public String getName() {
        return getKakao_account().getProfile().getNickname();
    }
    

    @Getter
    public static class KakaoAccount {
    	
    	private Profile profile;
    	
    	private String email;
    	
    	@Getter
        public static class Profile {
    		
            private String nickname;
    		
            private String thumbnail_image_url;
            
            private String profile_image_url;
        }
    }

   

}
