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

        #createGroupPopup {
            display: none;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
            border-radius: 5px;
            z-index: 3;
            width: 300px;
            font-family: "Helvetica Neue", Arial, sans-serif;
        }

        #createGroupPopup h3 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
            font-family: Arial, sans-serif;
            font-weight: bold;
            color: #333;
        }

        #createGroupPopup div {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        #createGroupPopup label {
            font-size: 18px;
            margin-bottom: 10px;
            font-family: Arial, sans-serif;
            font-weight: bold;
            color: #333;
        }

        #createGroupPopup input {
            font-size: 16px;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
            width: 100%; /* Adjust the width as desired */
            font-family: "Helvetica Neue", Arial, sans-serif;
        }

        #createGroupPopup button {
            display: inline-block;
            background-color: #84cd86;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease; /* Add transition effect */
            font-family: "Helvetica Neue", Arial, sans-serif;
            font-weight: bold;
            text-transform: uppercase;
        }

        #createGroupPopup button:hover {
            background-color: #68a567; /* Change background color on hover */
        }

        #createGroupPopup button + button {
            background-color: #e9675e;
            margin-left: 10px; /* Add spacing between buttons */
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
            <a href="#" onclick="managePopup()">管理拼团人员</a>
        </div>
    </div>
    <a href="#" onclick="invitePopup()">加入拼团</a>
</div>

<div id="createGroupPopup" style="display: none; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background-color: #fff; padding: 20px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3); border-radius: 5px; z-index: 3;">
    <%--@declare id="starttime"--%><h3>发起活动</h3>
    <input type="hidden" name="activityId" id="activityId">
    <input type="hidden" name="leaderName" id="leaderName" value="<%= username %>">
    <br>
    <label for="activityName">活动内容:</label>
    <input type="text" id="activityName">
    <br>
    <input type="hidden" name="location" id="location" >
    <input type="hidden" name="lng" id="lng" >
    <input type="hidden" name="lat" id="lat" >
    <br>
    <label for="startTime">活动时间：</label>
    <input type="datetime-local" id="startTime">
    <br>
    <label for="capacity">活动人数:</label>
    <input type="number" id="capacity">
    <br>
    <label for="duration">持续时间:</label>
    <input type="text" id="duration">
    <br>
    <label for="money">活动费用:</label>
    <input type="text" id="money">
    <br>
    <button  onclick="showConfirmation()">创建</button>
    <button  onclick="hidePopup()">退出</button>
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
    // 侧边栏
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
    // 绑定下拉菜单点击事件
    var dropdownToggle = document.querySelector('.dropdown-toggle');
    var dropdownContent = document.querySelector('.dropdown-content');

    dropdownToggle.addEventListener('click', function() { // 绑定点击事件
        dropdownContent.style.display = (dropdownContent.style.display === 'block') ? 'none' : 'block';
    });
</script>

<script type="text/javascript">
    // GL版命名空间为BMapGL
    // 按住鼠标右键，修改倾斜角和角度
    var map = new BMapGL.Map("map");    // 创建Map实例
    map.centerAndZoom('苏州市', 12);  // 初始化地图,设置中心点坐标和地图级别
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    map.disableDoubleClickZoom(); // 禁用双击放大
    var scaleCtrl = new BMapGL.ScaleControl();  // 添加比例尺控件
    map.addControl(scaleCtrl);
    var navi3DCtrl = new BMapGL.NavigationControl3D();  // 添加3D控件
    map.addControl(navi3DCtrl);

    var addButtonClicked = false;
    var addButton = document.querySelector('#addButton'); // 获取添加按钮
    addButton.addEventListener('click', function() { // 绑定点击事件
        addButtonClicked = !addButtonClicked; // 切换按钮状态
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
                        // 更新隐藏输入框的值
                        var locationInput = document.getElementById('location');
                        locationInput.value = address;
                    }
                });
            });
            // 更新隐藏输入框的值
            var lngInput = document.getElementById('lng'); // 获取经度输入框
            var latInput = document.getElementById('lat'); // 获取纬度输入框
            lngInput.value = e.latlng.lng; // 将经度值传递到隐藏输入框
            latInput.value = e.latlng.lat; // 将纬度值传递到隐藏输入框
            // 创建逆地理编码对象
            var geocoder = new BMapGL.Geocoder();
            geocoder.getLocation(point, function(result) {
                if (result) {
                    var address = result.address; // 获取地址信息
                    // 更新隐藏输入框的值
                    var locationInput = document.getElementById('location');
                    locationInput.value = address;
                }
            });
        }else {
            alert('请先点击添加按钮!');
        }
    });
    // 双击地图事件处理函数
    map.addEventListener('dblclick', onMapDoubleClick);
    function onMapDoubleClick(e) {
        // 显示创建拼团的弹窗
        var popup = document.getElementById('createGroupPopup');
        if (addButtonClicked) {
            popup.style.display = 'block'; // 显示弹窗

            var confirmation = true;
            // 创建按钮点击事件处理函数
            function showConfirmation() { // 显示确认弹窗
                var activityId = document.getElementById("activityId").value;
                var leaderName = document.getElementById("leaderName").value;
                var activityName = document.getElementById("activityName").value;
                var location = document.getElementById("location").value;
                var startTime = document.getElementById("startTime").value;
                var capacity = document.getElementById("capacity").value;
                var duration = document.getElementById("duration").value;
                var money = document.getElementById("money").value;
                var lng = document.getElementById("lng").value;
                var lat = document.getElementById("lat").value;

                if (confirmation) {
                    // 在此处可以将拼团信息提交到后端进行处理
                    var params = {
                        activityId: activityId,
                        leaderName: leaderName,
                        activityName: activityName,
                        location: location,
                        startTime: startTime,
                        duration: duration,
                        capacity: capacity,
                        money: money,
                        lng: lng,
                        lat: lat
                    };
                    // 发送POST请求到后端
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "/addActivity", true);
                    xhr.setRequestHeader("Content-type", "application/json");
                    xhr.onreadystatechange = function () {
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
                    infoWindowContent += '<p style="margin: 5px;">活动地点: ' + location + '</p>';

                    infoWindowContent += '</div>';
                    var infoWindowOptions = {
                        width: 200,
                        height: 150,
                        title: activityName,
                    };
                    var infoWindow = new BMapGL.InfoWindow(infoWindowContent, infoWindowOptions);
                    marker.addEventListener('click', function () {
                        map.openInfoWindow(infoWindow, point);
                    });
                    confirmation = false;
                }


                // 隐藏创建拼团的弹窗
                popup.style.display = 'none';
                removeEventListener('click', showConfirmation)
            }

            // 绑定创建按钮点击事件
            var createButton = document.querySelector('#createGroupPopup button');
            createButton.addEventListener('click', showConfirmation);
        }
    }

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

        // 创建表格元素
        var table = popupWindow.document.createElement("table");

        // 在表格中添加表头
        var headerRow = table.insertRow();
        var headerCell1 = headerRow.insertCell();
        headerCell1.textContent = "项目编号";
        var headerCell2 = headerRow.insertCell();
        headerCell2.textContent = "项目名称";

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
                    // 添加编辑按钮
                    var editButton = document.createElement('button');
                    editButton.textContent = '编辑';
                    editButton.addEventListener('click', function () {
                        editActivity(activity.activityId); // 调用编辑方法，并传递活动 ID
                    });
                    var editCell = row.insertCell();
                    editCell.appendChild(editButton);

                    // 添加删除按钮
                    var deleteButton = document.createElement('button');
                    deleteButton.textContent = '删除';
                    deleteButton.dataset.activityId = activity.activityId; // 将活动 ID 存储在 dataset 中
                    deleteButton.addEventListener('click', function() {
                        var activityId = this.dataset.activityId; // 获取活动ID
                        deleteActivity(activityId); // 调用删除方法，并传递活动 ID
                    });
                    var deleteCell = row.insertCell();
                    deleteCell.appendChild(deleteButton);

                    // 添加一个导出按钮
                    var exportButton = document.createElement('button');
                    exportButton.textContent = '导出账单';
                    exportButton.dataset.activityId = activity.activityId; // 将活动ID存储在dataset中
                    exportButton.addEventListener('click', function() {
                        var activityId = this.dataset.activityId; // 获取活动ID
                        exportBill(activityId); // 调用导出方法并传递活动ID
                    });
                    var exportCell = row.insertCell();
                    exportCell.appendChild(exportButton);

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

    function exportBill(activityId) {
        fetch('/exportToExcel', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ activityId: activityId }) // 将要编辑的活动ID发送给后端
        })
            .then(response => response.blob())
            .then(blob => {
                // 创建一个临时的URL对象
                const url = window.URL.createObjectURL(blob);
                // 创建一个<a>元素
                const a = document.createElement('a');
                // 设置下载属性
                a.href = url;
                a.download = 'activities.xlsx';
                // 添加<a>元素到文档中
                document.body.appendChild(a);
                // 触发点击事件
                a.click();
                // 删除<a>元素
                document.body.removeChild(a);
                // 释放URL对象
                window.URL.revokeObjectURL(url);
            });
    }


    // 编辑活动的方法
    function editActivity(activityId) {

        var leftPosition = (window.innerWidth - 400) / 2;
        var topPosition = (window.innerHeight - 300) / 2;
        // 创建一个新的弹窗
        var editPopupWindow = window.open('', '_blank', 'width=400,height=300,left=' + leftPosition + ',top=' + topPosition);
        editPopupWindow.document.write('<html><body>');

        // 创建表单元素
        var form = editPopupWindow.document.createElement("form");

        // 从后端获取数据并填充表单
        fetch('/getActivity', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ activityId: activityId }) // 将要编辑的活动ID发送给后端
        })
            .then(response => response.json())
            .then(data => {
                // 将数据填充到表单中
                data.forEach(function(activity) {
                    var form = editPopupWindow.document.createElement("form");

                    var activityIdInput = editPopupWindow.document.createElement("input");
                    activityIdInput.type = "text";
                    activityIdInput.value = activity.activityId;
                    form.appendChild(activityIdInput);

                    var leaderNameInput = editPopupWindow.document.createElement("input");
                    leaderNameInput.type = "text";
                    leaderNameInput.value = activity.leaderName;
                    form.appendChild(leaderNameInput);

                    var activityNameInput = editPopupWindow.document.createElement("input");
                    activityNameInput.type = "text";
                    activityNameInput.value = activity.activityName;
                    form.appendChild(activityNameInput);

                    var locationInput = editPopupWindow.document.createElement("input");
                    locationInput.type = "text";
                    locationInput.value = activity.location;
                    form.appendChild(locationInput);

                    var startTimeInput = editPopupWindow.document.createElement("input");
                    startTimeInput.type = "text";
                    startTimeInput.value = activity.startTime;
                    form.appendChild(startTimeInput);

                    var  capacityInput = editPopupWindow.document.createElement("input");
                    capacityInput.type = "text";
                    capacityInput.value = activity.capacity;
                    form.appendChild( capacityInput);

                    var moneyInput = editPopupWindow.document.createElement("input");
                    moneyInput.type = "text";
                    moneyInput.value = activity.money;
                    form.appendChild(moneyInput);

                    var durationInput = editPopupWindow.document.createElement("input");
                    durationInput.type = "text";
                    durationInput.value = activity.duration;
                    form.appendChild(durationInput);

                // 添加其他属性的输入字段

                    // 创建保存按钮并添加点击事件处理程序
                    var saveButton = editPopupWindow.document.createElement('button');
                    saveButton.textContent = '保存';
                    saveButton.addEventListener('click', function () {
                        // 获取表单数据
                        var editedData = {
                            activityId: activityIdInput.value,
                            leaderName: leaderNameInput.value,
                            activityName: activityNameInput.value,
                            location: locationInput.value,
                            startTime: startTimeInput.value,
                            capacity: capacityInput.value,
                            money: moneyInput.value,
                            duration: durationInput.value
                            // 获取其他属性的值
                        };

                        // 将编辑后的数据发送到后端进行更新
                        fetch('/updateActivity', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify(editedData)
                        })
                            .then(response => {
                                // 处理保存成功后的逻辑
                                // 关闭弹窗等操作
                                editPopupWindow.close(); // 关闭表单弹窗
                                popupWindow.close();
                                creatPopup();
                            })
                            .catch(error => {
                                console.error('Error:', error);
                            });
                    });

                    form.appendChild(saveButton);

                    editPopupWindow.document.body.appendChild(form);
                });

            })
            .catch(error => {
                console.error('Error:', error);
            });

        // 将表单添加到弹窗中
        editPopupWindow.document.body.appendChild(form);

        editPopupWindow.document.write('</body></html>');
    }


    // 在弹窗中创建表格的代码


    // 后端删除方法
    function deleteActivity(activityId) {
            // 向后端发送删除请求
            fetch('/deleteActivity', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ activityId: activityId }) // 将活动 ID 以 JSON 格式发送
            })
                //删除后刷新表单页面
                .then(response => {
                    if (response.status === 200) {
                        popupWindow.close();
                        creatPopup();
                    }
                })
    }
    function closePopup() {
        if (popupWindow && !popupWindow.closed) {
            popupWindow.close();
        }
    }


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
        var table = popupWindow.document.createElement("table");

        // 在表格中添加表头
        var headerRow = table.insertRow();
        var headerCell1 = headerRow.insertCell();
        headerCell1.textContent = "项目编号";
        var headerCell2 = headerRow.insertCell();
        headerCell2.textContent = "项目名称";

        // 使用 fetch 发送请求向后端获取数据
        fetch('/JoinActivities', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({username: '<%= username %>'}) // 将数据以 JSON 格式发送
        })
            .then(response => response.json())
            .then(data => {
                // 在弹窗中填充从后端获取的数据
                data.forEach(function (activity) {
                    var row = table.insertRow();
                    var cell1 = row.insertCell();
                    cell1.textContent = activity.activityId;
                    var cell2 = row.insertCell();
                    cell2.textContent = activity.activityName;

                    // 添加退出团队按钮
                    var quitButton = popupWindow.document.createElement('button');
                    quitButton.textContent = '退出团队';
                    quitButton.dataset.activityId = activity.activityId; // 将活动 ID 存储在 dataset 中
                    quitButton.addEventListener('click', function () {
                        var activityId = this.dataset.activityId; // 获取活动ID
                        quitTeam(activityId); // 调用退出团队方法，并传递活动 ID
                    });
                    var quitCell = row.insertCell();
                    quitCell.appendChild(quitButton);


                    // 添加导出按钮
                    var exportButton = popupWindow.document.createElement('button');
                    exportButton.textContent = '导出账单';
                    exportButton.dataset.activityId = activity.activityId; // 将活动ID存储在dataset中
                    exportButton.addEventListener('click', function () {
                        var activityId = this.dataset.activityId; // 获取活动ID
                        exportBill(activityId); // 调用导出方法并传递活动ID
                    });
                    var exportCell = row.insertCell();
                    exportCell.appendChild(exportButton);
                });  // 将表格添加到弹窗的<body>中
                popupWindow.document.body.appendChild(table);

                popupWindow.document.write('</body></html>');
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

        function closePopup() {
        if (popupWindow && !popupWindow.closed) {
            popupWindow.close();
        }
    }
    function quitTeam(activityId) {
        // 向后端发送请求，执行退出团队操作
        fetch('/QuitTeam', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ activityId: activityId,
                username: '<%= username %>'})
        })
            .then(response => response.json())
            .then(data => {
                popupWindow.close();
                joinPopup();
                console.log('退出团队成功');
                // 这里可以根据需要进行其他操作，例如刷新表格或重新加载数据
            })
            .catch(error => {
                console.error('退出团队失败:', error);
                // 处理退出团队失败的逻辑
            });
    }

    //人员管理弹窗
    function managePopup(){
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
        // 创建表格元素
        var table = popupWindow.document.createElement("table");

        // 在表格中添加表头
        var headerRow = table.insertRow();
        var headerCell1 = headerRow.insertCell();
        headerCell1.textContent = "项目编号";
        var headerCell2 = headerRow.insertCell();
        headerCell2.textContent = "项目名称";
        var headerCell3 = headerRow.insertCell();
        headerCell3.textContent = "成员名称";



        // 从后端获取数据并填充表格
        // 使用 fetch 发送请求向后端获取数据
        fetch('/manage', {
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
                    var cell3 = row.insertCell();
                    cell2.textContent = activity.memberName;
                    // 添加其他属性到表格中
                    // 添加踢出按钮
                    var kickButton = popupWindow.document.createElement('button');
                    kickButton.textContent = '踢出';
                    kickButton.dataset.activityId = activity.activityId; // 将活动 ID 存储在 dataset 中
                    kickButton.dataset.memberName = activity.memberName; // 将用户名存储在 dataset 中
                    kickButton.addEventListener('click', function() {
                        var activityId = this.dataset.activityId; // 获取活动ID
                        var memberName = this.dataset.memberName; // 获取用户名
                        kickOutUser(activityId, memberName); // 调用踢出用户方法，并传递活动 ID 和用户名
                    });
                    var kickCell = row.insertCell();
                    kickCell.appendChild(kickButton);

                });
            })
            .catch(error => {
                console.error('Error:', error);
            });
        // 将表格添加到弹窗中
        popupWindow.document.body.appendChild(table);

        popupWindow.document.write('</body></html>');

    }

    function kickOutUser(activityId, memberName) {
        // 使用 fetch 发送请求向后端执行删除操作
        fetch('/QuitTeam', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ activityId: activityId, username: memberName }) // 将活动ID和用户名以JSON格式发送
        })
            .then(response => response.json())
            .then(data => {
                popupWindow.close();
                managePopup();
                console.log('用户已成功踢出');
                // 可以根据需要进行一些其他的操作或刷新页面
            })
            .catch(error => {
                console.error('踢出用户失败:', error);
            });
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
        // 创建表格元素
        var table = popupWindow.document.createElement("table");

        // 在表格中添加表头
        var headerRow = table.insertRow();
        var headerCell1 = headerRow.insertCell();
        headerCell1.textContent = "项目编号";
        var headerCell2 = headerRow.insertCell();
        headerCell2.textContent = "项目名称";


        // 从后端获取数据并填充表格
        // 使用 fetch 发送请求向后端获取数据
        fetch('/addActivitys', {
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
                    // 添加确认加入按钮
                    var confirmButton = document.createElement('button');


                    confirmButton.textContent = '确认加入';
                    confirmButton.addEventListener('click', function () {
                        confirmActivity(activity.activityId); // 调用编辑方法，并传递活动 ID
                    });
                    var confirmCell = row.insertCell();
                    confirmCell.appendChild(confirmButton);
                    // 可以根据实际的Activity对象的属性来添加到表格中的对应单元格
                });
            })
            .catch(error => {
                console.error('Error:', error);
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


    // Toggle dropdown
    var dropdownToggle = document.querySelector('.dropdown-toggle');
    var dropdownContent = document.querySelector('.dropdown-content');

    dropdownToggle.addEventListener('click', function() {
        dropdownContent.style.display = (dropdownContent.style.display === 'block') ? 'none' : 'block';
    });

    var popupWindow;
    function confirmActivity(activityId) {
        fetch('/joinActivity', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                activityId: activityId,
                username: '<%= username %>'
            })
        })
            .then(response => {
                if (response.ok) {
                    popupWindow.close();
                    invitePopup();
                } else {
                    console.error('确认加入活动失败:', response.status);
                }
            })
            .catch(error => {
                console.error('错误:', error);
            });
    }



</script>

</body>
</html>
