package com.common.login.basic;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class BasicMemberDto {
    private Long id;
    private String email;
    private String password;
    private String nickname;
    private LocalDateTime createdDate;
    private LocalDateTime modifiedDate;
    
    public BasicUser toEntity(){
        return BasicUser.builder()
                .id(id)
                .email(email)
                .password(password)
                .nickname(nickname)
                .build();
    }

    @Builder
    public BasicMemberDto(Long id, String email, String password, String nickname) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.nickname = nickname;
    }
}
