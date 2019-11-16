package com.common.login.basic;

import org.springframework.data.jpa.repository.JpaRepository;

public interface BasicUserRepository extends JpaRepository<BasicUser, Long> {
	BasicUser findByEmailAndProviderIdIsNull(String email);
}
