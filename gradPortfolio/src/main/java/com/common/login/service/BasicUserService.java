package com.common.login.service;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.common.basic.login.entity.BasicMemberDto;
import com.common.basic.login.entity.BasicUser;
import com.common.basic.login.entity.BasicUserRepository;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BasicUserService implements UserDetailsService{
	private BasicUserRepository memberRepository;

	 @Transactional
	    public Long joinUser(BasicMemberDto memberDto) {
		 	
	        // 비밀번호 암호화
		 	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	        memberDto.setPassword(passwordEncoder.encode(memberDto.getPassword()));

	        return memberRepository.save(memberDto.toEntity()).getId();
	    }

	    @Override
	    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
	    	BasicUser userEntity = memberRepository.findByEmail(email);
	    	
	    	if (userEntity == null) {
	    		throw new UsernameNotFoundException(email);
			}
	    	
	        List<GrantedAuthority> authorities = new ArrayList<>();
	        return new User(userEntity.getEmail(), userEntity.getPassword(), authorities);
	    }
	    
	    /**
	     * Email 중복체크
	     * @param email
	     * @return
	     * @throws UsernameNotFoundException
	     */
	    public boolean isDuplicateCheck(String email) {
	    	boolean result = false;
	    	BasicUser userEntity = memberRepository.findByEmail(email);
	    	
	    	if (userEntity == null) {
	    		result = true;
			}
	        
	        return result;
	    }
	    
	    
}
		