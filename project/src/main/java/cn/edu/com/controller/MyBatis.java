package cn.edu.com.controller;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan("cn.edu.com.mapper")
public class MyBatis {
    // 其他配置
}
