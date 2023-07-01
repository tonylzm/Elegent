<%--
  Created by IntelliJ IDEA.
  User: LINZHIMING
  Date: 2023/7/1
  Time: 13:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post" action="regedit.jsp">
    <input type="text" name="username" value="请输入用户名">
    <input type="password" name="password" value="请输入密码">
    <input type="submit" value="注册">
</form>

</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $('form').submit(function(e) {
            e.preventDefault(); // 阻止表单默认提交行为

            const username = $('input[name="username"]').val(); // 获取用户名字段的值
            const password = $('input[name="password"]').val();

            $.ajax({
                url: '/api/encrypt', // 后端加密API的URL
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ username: username, password: password }), // 包含用户名和密码的数据
                success: function(data) {
                    const encryptedPassword = data.encryptedPassword;
                    $('input[name="password"]').val(encryptedPassword); // 将加密后的密码设置到密码字段
                    $('form')[0].submit(); // 提交表单
                },
                error: function(error) {
                    console.log('加密密码时发生错误', error);
                }
            });
        });
    });
</script>


</body>
</html>
