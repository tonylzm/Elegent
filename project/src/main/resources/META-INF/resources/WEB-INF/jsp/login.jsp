<%--
  Created by IntelliJ IDEA.
  User: LINZHIMING
  Date: 2023/7/1
  Time: 15:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <title>登录</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<c:url value='https://unpkg.com/element-ui/lib/theme-chalk/index.css'/>">
    <style>
        body {
            background-image: linear-gradient(180deg, #49fbab 0%, #1ba8ff 100%);
        }

        .login-page {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-title {
            font-size: 20px;
        }

        .box-card {
            width: 375px;
        }

        .reg-bar {
            width: 360px;
            margin: 20px auto 0;
            font-size: 14px;
            overflow: hidden;
        }

        .reg-bar a {
            color: #000000;
            text-decoration: none;
        }

        .reg-bar a:hover {
            text-decoration: underline;
        }

        .reg-bar .reg {
            float: left;
        }
    </style>
</head>

<body>
<div id="app">
    <div class="login-page">
        <el-card class="box-card">
            <div slot="header" class="clearfix">
                <span class="login-title">登录</span>
            </div>
            <div class="login-form">
                <el-form :model="form" :rules="loginRules" ref="loginForm" >
                    <el-form-item prop="username">
                        <el-input type="text" v-model="form.username" auto-complete="off" placeholder="请输入账号">
                            <template slot="prepend"><i style="font-size:20px" class="el-icon-user"></i></template>
                        </el-input>
                    </el-form-item>
                    <el-form-item prop="password">
                        <el-input type="password" v-model="form.password" auto-complete="off" placeholder="请输入密码">
                            <template slot="prepend"><i style="font-size:20px" class="el-icon-key"></i></template>
                        </el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button style="width: 210px;" type="primary" @click="handleLogin" :loading="loading">登录</el-button>
                        <el-button style="width: 110px;" @click="goToZhucePage">注册</el-button>

                    </el-form-item>
                </el-form>
            </div>
        </el-card>
    </div>
</div>

<script src="https://unpkg.com/vue@2/dist/vue.js"></script>
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/qs/dist/qs.js"></script>

<script>
    new Vue({
        el: '#app',
        data: {
            loading: false,
            form: {
                account: '',
                username: '',
                password: '',
                avatar: null,
            },
            loginRules: {
                username: [
                    {required: true, message: '请输入账户名', trigger: 'blur'},
                ],
                account: [
                    {required: true, message: '请输入账号', trigger: 'blur'},
                ],
                password: [
                    {required: true, message: '请输入密码', trigger: 'blur'}
                ]
            },
        },
        methods: {
            goToZhucePage() {
                window.location.href = "zhuce.jsp";
            },
            decryptPassword(password) {
                return password;
            },
            handleLogin() {
                // 解密密码
                const decryptedPassword = this.decryptPassword(this.form.password);

                // 创建请求数据对象，包含username和解密后的密码
                const requestData = {
                    username: this.form.username,
                    password: decryptedPassword
                };

                // 发送登录请求到服务器
                axios.post('<c:url value="/api/login"/>', requestData)
                    .then(response => {
                        // 处理登录成功
                        console.log(response.data); // 登录成功的响应数据

                        // 获取登录成功后的用户名
                        const username = response.data;

                        // 将用户名存储到本地存储或Cookie中，以便在跳转后的页面获取
                        // 这里以使用localStorage为例
                        localStorage.setItem('username', username);
                        this.$message.success('登录成功');
                        // 跳转到主页面
                        window.location.href = "index.jsp";
                    })
                    .catch(error => {
                        // 处理登录失败
                        console.log(error.response.data); // 登录失败的错误信息
                        this.$message.error('登录失败');
                    });
            }
        }
        });
</script>



