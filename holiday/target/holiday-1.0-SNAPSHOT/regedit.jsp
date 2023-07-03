<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% String username = (String) request.getSession().getAttribute("username"); %>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
          integrity="sha512-*****************" crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha384-*****************" crossorigin="anonymous"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <style type="text/css">
        body, html,
        #map {
            overflow: hidden;
            width: 100%;
            height: 100%;
            margin: 0;
            font-family: "微软雅黑";
        }
        .round_icon{
            width: 34px;
            height: 34px;
            display: flex;
            border-radius: 50%;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: #f1f1f1;
            overflow-x: hidden;
            padding-top: 20px;
        }

        /* Sidebar links */
        .sidebar a {
            display: block;
            color: black;
            padding: 16px;
            text-decoration: none;
        }

        /* Active/current link */
        .sidebar a.active {
            background-color: #4CAF50;
            color: white;
        }

        /* Sidebar header */
        .sidebar .header {
            background-color: #555;
            color: white;
            font-size: 20px;
            padding: 16px;
        }

        /* Content */
        .content {
            margin-left: 250px;
            padding: 16px;
        }

        /* Toggle button */
        .toggle-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 30px;
            cursor: pointer;
            color: #555;
        }

        /* Animation */
        @keyframes slide-in {
            from { transform: translateX(-100%); }
            to { transform: translateX(0); }
        }

        @keyframes slide-out {
            from { transform: translateX(0); }
            to { transform: translateX(-100%); }
        }

        .slide-in {
            animation: slide-in 0.5s forwards;
        }

        .slide-out {
            animation: slide-out 0.5s forwards;
        }
        /* Dropdown styles */
        .dropdown-content {
            display: none;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }
        /* Dropdown styles */
        .dropdown-content {
            display: none;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        /* 动画按钮的CSS样式 */
        .btn {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 3;
            background-color: #c5d3d2; /* 新的背景颜色 */
            border: none; /* 移除边框 */
            color: white; /* 白色文本 */
            padding: 12px 16px; /* 一些填充 */
            font-size: 16px; /* 设置字体大小 */
            cursor: pointer; /* 鼠标悬停 */
            transition: background-color 0.3s, transform 0.3s; /* 添加过渡效果 */
            border-radius: 45px; /* 圆角 */
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3); /* 阴影 */
        }

        /* 鼠标悬停时背景变暗 */
        .btn:hover {
            background-color: #818a81; /* 新的悬停背景颜色 */
        }

    </style>
    <script type="text/javascript" src="https://api.map.baidu.com/api?type=webgl&v=1.0&ak=VxXMwTrk3B9lrfDkxRFRvnvUXx1Wq1cy"></script>
    <title>地图展示</title>
</head>
<body>
<div id="map" style="position: fixed; top: 0; right: 0; bottom: 0; left: 250px; z-index: 1;"></div>

<div class="sidebar">
    <div class="header"><img src="pictures/1.JPG" class="round_icon">欢迎您，<%= username %>！</div>
    <a href="#" class="active">拼团</a>
    <div class="dropdown">
        <a href="#" class="dropdown-toggle">我的活动</a>
        <div class="dropdown-content">
            <a href="#" class="dropdown-toggle" onclick="creatPopup()">我发起的拼团</a>
            <a href="#" onclick="joinPopup()">我加入的拼团</a>
        </div>
    </div>
    <a href="#" onclick="invitePopup()">项目邀请</a>
</div>
<div id="createGroupPopup" style="display: none; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background-color: #fff; padding: 20px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3); border-radius: 5px; z-index: 3;">
    <h3>发起活动</h3>
    <input type="hidden" name="activityId" id="activityId">
    <label for="leaderName">团长名称：</label>
    <input type="text" name="leaderName" id="leaderName" readonly value="<%= username %>">
    <br>
    <label for="activityName">活动内容:</label>
    <input type="text" id="activityName">
    <br>
    <label for="location">活动地点：</label>
    <input type="text" name="location" id="location">
    <br>
    <label for="startTime">活动时间:</label>
    <input type="text" id="startTime">
    <br>
    <label for="capacity">活动人数:</label>
    <input type="number" id="capacity">
    <br>
    <button onclick="showConfirmation()">创建</button>
    <button onclick="hidePopup()">退出</button>
</div>
<div>
    <button id="addButton" class="btn"><i class="fas fa-plus"></i></button>
</div>

<script type="text/javascript">
    const btn = document.querySelector('.btn');
    let rotationAngle = 0;
    btn.addEventListener('click', () => {
        rotationAngle += 45;
        btn.style.transform = `rotate(${rotationAngle}deg)`;
    });
</script>

<script type="text/javascript">
    // Toggle sidebar
    var toggleBtn = document.querySelector('.toggle-btn');
    var sidebar = document.querySelector('.sidebar');
    var content = document.querySelector('.content');

    toggleBtn.addEventListener('click', function() {
        if (sidebar.classList.contains('slide-in')) {
            sidebar.classList.remove('slide-in');
            sidebar.classList.add('slide-out');
            content.style.marginLeft = '0';
        } else {
            sidebar.classList.remove('slide-out');
            sidebar.classList.add('slide-in');
            content.style.marginLeft = '250px';
        }
    });

    function hidePopup() {
        document.getElementById('createGroupPopup').style.display = 'none';
    }
</script>

<script type="text/javascript">
    // GL版命名空间为BMapGL
    // 按住鼠标右键，修改倾斜角和角度
    var map = new BMapGL.Map("map");    // 创建Map实例
    map.centerAndZoom('苏州市', 12);  // 初始化地图,设置中心点坐标和地图级别
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    var scaleCtrl = new BMapGL.ScaleControl();  // 添加比例尺控件
    map.addControl(scaleCtrl);
    var navi3DCtrl = new BMapGL.NavigationControl3D();  // 添加3D控件
    map.addControl(navi3DCtrl);
    var addButtonClicked = false;
    var addButton = document.getElementById('addButton');

    addButton.addEventListener('click', function () {
        if (addButtonClicked) {
            addButtonClicked = false;
        } else {
            addButtonClicked = true;
        }
    });
    map.addEventListener('dblclick', function (e) {
        if (addButtonClicked) {
            // 创建点标记
            var point = new BMapGL.Point(e.latlng.lng, e.latlng.lat);
            var marker = new BMapGL.Marker(point);

            // 添加点标记
            map.addOverlay(marker);

            // 创建信息窗口
            var opts = {
                width: 200,
                height: 100,
                title: '垃圾分类志愿者'
            };

            // 右键删除点标记
            marker.addEventListener('rightclick', function() {
                map.removeOverlay(marker);
            });

            var infoWindow = new BMapGL.InfoWindow('', opts);

            // 点标记添加点击事件
            marker.addEventListener('click', function() {
                // 创建逆地理编码对象
                var geocoder = new BMapGL.Geocoder();

                // 根据坐标获取地址信息
                geocoder.getLocation(point, function(result) {
                    if (result) {
                        var address = result.address; // 获取地址信息
                        var formattedAddress = result.formattedAddress; // 获取格式化的地址信息

                        // 更新信息窗口内容
                        infoWindow.setContent('地址：' + address);
                        // 开启信息窗口
                        map.openInfoWindow(infoWindow, point);
                    }
                });
            });
        }else {
            alert('请先点击添加按钮!');
        }
    });
    var popupWindow;
    //我发起的拼团弹窗
    function creatPopup() {
        // 检查弹窗是否已打开，如果是，则先关闭
        if (popupWindow && !popupWindow.closed) {
            popupWindow.close();
        }

        // 计算弹窗居中位置
        var leftPosition = (window.innerWidth - 400) / 2;
        var topPosition = (window.innerHeight - 300) / 2;

        // 打开一个新的弹窗
        popupWindow = window.open('', '_blank', 'width=400,height=300,left=' + leftPosition + ',top=' + topPosition);
        popupWindow.document.write('<html><body>');
        popupWindow.document.write('<h1>欢迎团长！</h1>');

        // 创建表格元素
        var table = popupWindow.document.createElement("table");

        // 在表格中添加表头
        var headerRow = table.insertRow();
        var headerCell1 = headerRow.insertCell();
        headerCell1.textContent = "列1";
        var headerCell2 = headerRow.insertCell();
        headerCell2.textContent = "列2";

        // 从后端获取数据并填充表格
        // 使用 fetch 发送请求向后端获取数据
        fetch('/searchActivities', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ username: '<%= username %>' }) // 将数据以 JSON 格式发送
        })
            .then(response => response.json())
            .then(data => {
                // 在弹窗中填充从后端获取的数据
                data.forEach(function(activity) {
                    var row = table.insertRow();
                    var cell1 = row.insertCell();
                    cell1.textContent = activity.activityId;
                    var cell2 = row.insertCell();
                    cell2.textContent = activity.activityName;
                    // 添加其他属性到表格中

                    // 可以根据实际的Activity对象的属性来添加到表格中的对应单元格
                });
            })
            .catch(error => {
                console.error('Error:', error);
            });
        // 这里使用示例数据填充表格，你可以根据实际情况修改代码
        var data = [

            // ...
        ];

        // 遍历数据并创建表格行
        data.forEach(function (item) {
            var row = table.insertRow();
            var cell1 = row.insertCell();
            cell1.textContent = item.column1;
            var cell2 = row.insertCell();
            cell2.textContent = item.column2;
        });

        // 将表格添加到弹窗中
        popupWindow.document.body.appendChild(table);

        popupWindow.document.write('</body></html>');
    }

    function closePopup() {
        if (popupWindow && !popupWindow.closed) {
            popupWindow.close();
        }
    }
    //我加入的拼团弹窗
    function joinPopup() {
        // 检查弹窗是否已打开，如果是，则先关闭
        if (popupWindow && !popupWindow.closed) {
            popupWindow.close();
        }

        // 计算弹窗居中位置
        var leftPosition = (window.innerWidth - 400) / 2;
        var topPosition = (window.innerHeight - 300) / 2;

        // 打开一个新的弹窗
        popupWindow = window.open('', '_blank', 'width=400,height=300,left=' + leftPosition + ',top=' + topPosition);
        popupWindow.document.write('<html><body>');
        popupWindow.document.write('<h1>欢迎你加入！</h1>');
        popupWindow.document.write('</body></html>');
    }

    function closePopup() {
        if (popupWindow && !popupWindow.closed) {
            popupWindow.close();
        }
    }
    //项目邀请弹窗
    function invitePopup() {
        // 检查弹窗是否已打开，如果是，则先关闭
        if (popupWindow && !popupWindow.closed) {
            popupWindow.close();
        }

        // 计算弹窗居中位置
        var leftPosition = (window.innerWidth - 400) / 2;
        var topPosition = (window.innerHeight - 300) / 2;

        // 打开一个新的弹窗
        popupWindow = window.open('', '_blank', 'width=400,height=300,left=' + leftPosition + ',top=' + topPosition);
        popupWindow.document.write('<html><body>');
        popupWindow.document.write('<h1>你想邀请谁？</h1>');
        popupWindow.document.write('</body></html>');
    }

    function closePopup() {
        if (popupWindow && !popupWindow.closed) {
            popupWindow.close();
        }
    }


    // Toggle dropdown
    var dropdownToggle = document.querySelector('.dropdown-toggle');
    var dropdownContent = document.querySelector('.dropdown-content');

    dropdownToggle.addEventListener('click', function() {
        dropdownContent.style.display = (dropdownContent.style.display === 'block') ? 'none' : 'block';
    });
    // 双击地图事件处理函数
    function onMapDoubleClick(e) {
        // 获取双击的地理坐标
        var lng = e.point.lng;
        var lat = e.point.lat;

        // 显示创建拼团的弹窗
        var popup = document.getElementById('createGroupPopup');
        popup.style.display = 'block';

        // 创建按钮点击事件处理函数
        function showConfirmation() {
            var activityId = document.getElementById("activityId").value;
            var leaderName = document.getElementById("leaderName").value;
            var activityName = document.getElementById("activityName").value;
            var location = document.getElementById("location").value;
            var startTime = document.getElementById("startTime").value;
            var capacity = document.getElementById("capacity").value;

            var confirmation = confirm("是否确认发起拼团？");
            if (confirmation) {
                // 在此处可以将拼团信息提交到后端进行处理
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
                // 创建拼团信息标记
                var point = new BMapGL.Point(lng, lat);
                var marker = new BMapGL.Marker(point);
                // Add marker to map if addButton is clicked
                if (addButton.clicked) {
                    map.addOverlay(marker);
                }

                var infoWindowContent = '<div style="width: 200px;">';
                infoWindowContent += '<h4 style="margin: 5px;">' + activityName + '</h4>';
                infoWindowContent += '<p style="margin: 5px;">活动时间: ' + startTime + '</p>';
                infoWindowContent += '<p style="margin: 5px;">最大人数限制: ' + capacity + '</p>';
                infoWindowContent += '</div>';
                var infoWindowOptions = {
                    width: 200,
                    height: 150,
                    title: activityName,
                };
                var infoWindow = new BMapGL.InfoWindow(infoWindowContent, infoWindowOptions);
                marker.addEventListener('click', function() {
                    map.openInfoWindow(infoWindow, point);
                });
            }

            // 隐藏创建拼团的弹窗
            popup.style.display = 'none';
        }
        // 绑定创建按钮点击事件
        var createButton = document.querySelector('#createGroupPopup button');
        createButton.addEventListener('click', showConfirmation);
    }

    // 绑定添加按钮点击事件
    var addButton = document.querySelector('#addButton');
    addButton.addEventListener('click', function() {
        addButton.clicked = true;
        map.addEventListener('dblclick', onMapDoubleClick);
    });
    // 前端JavaScript代码

</script>

</body>
</html>
