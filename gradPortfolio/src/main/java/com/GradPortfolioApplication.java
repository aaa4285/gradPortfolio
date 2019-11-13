package com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
@EnableAutoConfiguration
@ComponentScan
@PropertySource("aws.properties")
public class GradPortfolioApplication{
	
	public static void main(String[] args) {
		SpringApplication.run(GradPortfolioApplication.class, args);
	}
	

}
