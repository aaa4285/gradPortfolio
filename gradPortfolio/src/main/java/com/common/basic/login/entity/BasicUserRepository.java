package com.common.basic.login.entity;

import org.springframework.data.jpa.repository.JpaRepository;

public interface BasicUserRepository extends JpaRepository<BasicUser, Long> {
	BasicUser findByEmail(String email);
}
