package cn.edu.com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyController {

    @GetMapping("/")
    public String home() {
        return "login"; // 返回对应的视图名称，例如 "index"
    }
}