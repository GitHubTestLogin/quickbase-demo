package com.quickbase.demo;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

    @GetMapping("/demo")
    public String demo() {
       
        return "Hello - Welcome to Quickbase Craft Demo CI CD Pipeline";
    }
}
