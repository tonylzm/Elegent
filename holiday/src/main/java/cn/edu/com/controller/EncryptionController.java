package cn.edu.com.controller;

import cn.edu.com.dao.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.security.crypto.password.PasswordEncoder;


import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class EncryptionController {
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserDao userDao;

    @PostMapping("/encrypt")
    public ResponseEntity<?> encryptPassword(@RequestBody Map<String, String> request) {
        String password = request.get("password");
        String username = request.get("username");
        String encryptedPassword = passwordEncoder.encode(password);

        // 创建User对象并设置加密后的密码
        User user = new User();
        user.setUsername(username);
        user.setPassword(encryptedPassword);

        // 将用户信息保存到数据库
        userDao.insertUser(user);

        Map<String, String> response = new HashMap<>();
        response.put("encryptedPassword", encryptedPassword);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> request) {
        String username = request.get("username");
        String password = request.get("password");

        // 从数据库中获取用户信息
        User user = userDao.getUserByUsername(username);

        if (user != null) {
            // 对用户输入的密码进行加密
            String encryptedPassword = passwordEncoder.encode(password);

            // 将加密后的密码与数据库中的密码进行比对
            if (passwordEncoder.matches(password, user.getPassword())) {
                // 密码正确，登录成功
                return ResponseEntity.ok("登录成功");
            }
        }

        // 密码错误或用户不存在，登录失败
        return ResponseEntity.badRequest().body("登录失败");
    }
}
