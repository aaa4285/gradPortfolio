package com.common.login.basic;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "user")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class BasicUser {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(length = 255, nullable = false)
    private String email;

    @Column(length = 300, nullable = false)
    private String password;
    
    @Column(length = 255, nullable = false)
    private String nickname;
    
    @Column(name = "provider_id", length = 255) 
    private String providerId;

    @Builder
    public BasicUser(Long id, String email, String password, String nickname, String providerId) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.nickname = nickname;
        this.providerId = providerId;
    }


}