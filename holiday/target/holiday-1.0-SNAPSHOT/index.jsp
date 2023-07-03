<% String username = (String) request.getSession().getAttribute("username"); %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>添加活动</title>
</head>
<body>
<form id="activityForm" method="post" action="/addActivity">
    <input type="hidden" name="activityId" id="activityId">
    <label for="leaderName">团长名称：</label>
    <input type="text" name="leaderName" id="leaderName" readonly value="<%= username %>">
    <br>
    <label for="activityName">活动名称：</label>
    <input type="text" name="activityName" id="activityName">
    <br>
    <label for="location">活动地点：</label>
    <input type="text" name="location" id="location">
    <br>
    <label for="startTime">活动起始时间：</label>
    <input type="text" name="startTime" id="startTime">
    <br>
    <label for="capacity">人数限制：</label>
    <input type="number" name="capacity" id="capacity">
    <br>
    <input type="submit" value="提交">
</form>
<button id="exportButton" onclick="exportToExcel()">导出到Excel</button>

<script>
    // 生成活动编号
    function generateActivityId() {
        var date = new Date();
        var activityId = date.getTime(); // 使用日期时间的毫秒数作为活动编号
        document.getElementById("activityId").value = activityId;
    }

    // 表单提交事件
    document.getElementById("activityForm").addEventListener("submit", function(event) {
        event.preventDefault(); // 阻止表单默认提交行为

        // 获取表单数据
        var activityId = document.getElementById("activityId").value;
        var leaderName = document.getElementById("leaderName").value;
        var activityName = document.getElementById("activityName").value;
        var location = document.getElementById("location").value;
        var startTime = document.getElementById("startTime").value;
        var capacity = document.getElementById("capacity").value;

        // 构建请求参数
        var params = {
            activityId: activityId,
            leaderName: leaderName,
            activityName: activityName,
            location: location,
            startTime: startTime,
            capacity: capacity
        };

        // 发送POST请求到后端
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/addActivity", true);
        xhr.setRequestHeader("Content-type", "application/json");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                // 请求成功，处理响应
                var response = JSON.parse(xhr.responseText);
                // 根据需要执行相应的操作
                console.log(response);
            }
        };
        xhr.send(JSON.stringify(params));
    });
    function exportToExcel() {
        // 获取团长名称
        var username = document.getElementById("leaderName").value;

        // 构建请求参数
        var params = {
            username: username
        };

        // 发送POST请求到后端获取Excel数据
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/exportActivitiesToExcel", true);
        xhr.setRequestHeader("Content-type", "application/json");
        xhr.responseType = "blob";
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                // 创建下载链接
                var blob = new Blob([xhr.response], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                var downloadUrl = URL.createObjectURL(blob);

                // 创建虚拟<a>标签并设置下载链接
                var a = document.createElement("a");
                a.href = downloadUrl;
                a.download = "activities.xlsx";
                a.style.display = "none";

                // 添加<a>标签到页面，并触发点击事件
                document.body.appendChild(a);
                a.click();

                // 清理资源
                document.body.removeChild(a);
                URL.revokeObjectURL(downloadUrl);
            }
        };
        xhr.send(JSON.stringify(params));
    }



    // 页面加载时执行
    window.onload = function() {
        generateActivityId();
    };
</script>
</body>
</html>
