package org.application;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"org.controller", "org.services", "org.config"})
public class PennyWiseApplication {
   public static void main(String[] args) {
       SpringApplication.run(PennyWiseApplication.class, args);
   }
}
