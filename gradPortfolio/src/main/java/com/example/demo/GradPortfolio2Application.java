package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan("com.common.*")
@SpringBootApplication
public class GradPortfolio2Application {

	public static void main(String[] args) {
		SpringApplication.run(GradPortfolio2Application.class, args);
	}

}
