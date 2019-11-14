package com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.EnableScheduling;

@Configuration
@EnableAutoConfiguration
@EnableScheduling
@ComponentScan
@Profile("local")
@PropertySource("aws.properties")
public class GradPortfolioApplication{
	
	public static void main(String[] args) {
		SpringApplication.run(GradPortfolioApplication.class, args);
	}
	

}
