package com.common.login.social.entity;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findBySocial(UserConnection userConnection);
}
