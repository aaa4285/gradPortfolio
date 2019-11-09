package com.common.login.entity;

import org.springframework.data.jpa.repository.JpaRepository;

import com.common.login.userconnection.UserConnection;

public interface UserRepository extends JpaRepository<User, Long> {

    User findBySocial(UserConnection userConnection);
}
