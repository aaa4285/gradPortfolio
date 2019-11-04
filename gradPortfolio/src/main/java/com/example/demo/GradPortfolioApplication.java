package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan("com.common.*")
@SpringBootApplication
public class GradPortfolioApplication{
	
	public static void main(String[] args) {
		SpringApplication.run(GradPortfolioApplication.class, args);
	}

}
