<%--
  Created by IntelliJ IDEA.
  User: LINZHIMING
  Date: 2023/7/1
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh">

<head>
  <title>注册</title>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
  <style>
    body {
      background-image: linear-gradient(180deg, #2bf198 0%, #30a7f1 100%);
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

    .avatar-uploader .el-upload {
      border: 1px dashed #d9d9d9;
      border-radius: 6px;
      cursor: pointer;
      position: relative;
      overflow: hidden;
    }

    .avatar-uploader .el-upload:hover {
      border-color: #409eff;
    }

    .avatar-uploader-icon {
      font-size: 28px;
      color: #8c939d;
      width: 100px;
      height: 100px;
      line-height: 100px;
      text-align: center;
    }

    .avatar {
      width: 100px;
      height: 100px;
      display: block;
    }
  </style>
</head>

<body>
<div id="app">
  <div class="login-page">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span class="login-title">注册</span>
      </div>
      <div class="login-form">
        <el-form :model="form" :rules="loginRules" ref="loginForm">
          <el-form-item prop="username">
            <el-input type="text" v-model="form.username" auto-complete="off" placeholder="请输入账户名">
              <template slot="prepend"><i style="font-size:20px" class="el-icon-s-promotion"></i></template>
            </el-input>
          </el-form-item>
          <el-form-item prop="account">
            <el-input type="text" v-model="form.account" auto-complete="off" placeholder="请输入账号">
              <template slot="prepend"><i style="font-size:20px" class="el-icon-user"></i></template>
            </el-input>
          </el-form-item>
          <el-form-item prop="password">
            <el-input type="password" v-model="form.password" auto-complete="off" placeholder="请输入密码">
              <template slot="prepend"><i style="font-size:20px" class="el-icon-lock"></i></template>
            </el-input>
          </el-form-item>
          <el-button style="width: 210px;" type="primary" @click="handleRegister" :loading="loading">确认注册
          </el-button>
          <el-button style="width: 110px;" @click="goToLoginPage">返回登录</el-button>

        </el-form>
      </div>
    </el-card>
  </div>
</div>

<script src="https://unpkg.com/vue@2/dist/vue.js"></script>
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
  new Vue({
    el: '#app',
    data: {
      form: {
        username: '',
        account: '',
        password: ''
      },
      loginRules: {
        username: [
          { required: true, message: '请输入账户名', trigger: 'blur' }
        ],
        account: [
          { required: true, message: '请输入账号', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ]
      }
    },
    methods: {
      goToLoginPage() {
        window.location.href = "login.jsp";
      },
      handleRegister() {
        this.$refs.loginForm.validate((valid) => {
          if (valid) {
            // 表单校验通过，发送注册请求
            const formData = {
              username: this.form.username,
              password: this.form.password,
              account: this.form.account
            };
            axios.post('/api/encrypt', formData)
                    .then((response) => {
                      // 注册成功的处理逻辑
                      console.log(response.data);
                      this.$message.success('注册成功');
                      this.goToLoginPage();// 跳转到登录页面
                    })
                    .catch((error) => {
                      // 注册失败的处理逻辑
                      console.error(error);
                      this.$message.error('注册失败');
                    });
          } else {
            // 表单校验不通过
            return false;
          }
        });
      }
    }
  });
</script>
</body>
</html>

