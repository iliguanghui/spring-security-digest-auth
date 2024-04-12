package com.lgypro.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HelloController {

    @GetMapping("/")
    @ResponseBody
    public String hello() {
        String name = SecurityContextHolder.getContext().getAuthentication().getName();
        return String.format("Hello %s, Welcome to Spring Security!%n", name);
    }
}
