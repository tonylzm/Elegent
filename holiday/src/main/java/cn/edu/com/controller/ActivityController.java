package cn.edu.com.controller;

import cn.edu.com.entity.Activity;
import cn.edu.com.service.ActivityService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.util.List;

@RestController
public class ActivityController {
    @Autowired
    private ActivityService activityService;

    @PostMapping("/addActivity")
    public String addActivity(@RequestBody Activity activity) {
        // 生成活动编号和团长名称
        long activityId = generateRandomId();
        activity.setActivityId(activityId);

        // 保存活动到数据库
        activityService.saveActivity(activity);

        return "Activity added successfully.";
    }

    private long generateRandomId() {
        // 使用当前时间戳作为基础
        long timestamp = System.currentTimeMillis();

//        // 生成一个随机数或其他唯一标识符
//        // 这里使用 Math.random() 生成一个 6 位数的随机数，你也可以根据需求选择其他方式生成唯一标识符
//        int random = (int) (Math.random() * 900000) + 100000;

        // 将时间戳和随机数组合成一个唯一的 ID
        return timestamp ;
    }
@PostMapping("/searchActivities")
public List<Activity> searchActivities(@RequestBody RequestData requestData) {
    String username = requestData.getUsername();
    List<Activity> activities = activityService.getActivitiesByUsername(username);
    System.out.println(activities);
    return activities;
}
@PostMapping("/addActivitys")
public List<Activity> addActivity(@RequestBody RequestData requestData) {
    String username = requestData.getUsername();
    List<Activity> activities = activityService.addActivity(username);
    System.out.println(activities);
    return activities;

}
@PostMapping("/deleteActivity")
public String deleteActivity(@RequestBody RequestData requestData) {
        Long activityId = requestData.getActivityId();
        activityService.deleteActivityById(activityId);
        return "Activity deleted successfully.";
    }

    @PostMapping("/getActivity")
    public List<Activity> getActivity(@RequestBody RequestData requestData) {
        Long activityId = requestData.getActivityId();
        List<Activity> activities=activityService.getActivityById(activityId);
        System.out.println(activities);
        return activities;
    }
    @PostMapping("/updateActivity")
    public String updateActivity(@RequestBody Activity activity) {
        activityService.updateActivity(activity);
        return "Activity updated successfully.";
    }
    @PostMapping("/joinActivity")
    public String joinActivity(@RequestBody RequestData requestData){
        Long activityId = requestData.getActivityId();
        String username = requestData.getUsername();
        activityService.joinActivity(activityId,username);
        return "Join Successfully";
    }

    @PostMapping("/JoinActivities")
    public List<Activity> JoinActivities(@RequestBody RequestData requestData){
        String username = requestData.getUsername();
        List<Activity> activities=activityService.getJoinActivities(username);
        return activities;
    }

    @PostMapping("/QuitTeam")
    public String QuitTeam(@RequestBody RequestData requestData){
        Long activityId = requestData.getActivityId();
        String username = requestData.getUsername();
        activityService.QuitTeam(activityId,username);
        return "Join Successfully";
    }

    @PostMapping("/manage")
    public List<Activity> manage(@RequestBody RequestData requestData){
        String username = requestData.getUsername();
        List<Activity> activities=activityService.manage(username);
        return activities;
    }

    @PostMapping("/exportToExcel")
    public  ResponseEntity<byte[]> exportToExcel(@RequestBody RequestData requestData) throws IOException {
        Long activityId = requestData.getActivityId();
        List<Activity> activities = activityService.getMemberById(activityId);
        // 计算总消费和总人数
        double totalMoney = 0.0;
        int totalMembers = activities.size();
        for (Activity activity : activities) {
            totalMoney = activity.getMoney();
        }
        double sharedMoney = totalMoney / (totalMembers+1);//团长也要分摊
        System.out.println(sharedMoney);
        System.out.println(totalMembers);
        System.out.println(totalMoney);
        System.out.println(activities);

        // 创建一个新的工作簿
        Workbook workbook = new XSSFWorkbook();
        // 创建一个工作表
        Sheet sheet = workbook.createSheet("Activities");

        // 创建表头
        String[] headers = {"活动编号", "团长名称", "活动名称", "活动地点", "开始时间", "成员","应支付金额"};
        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }
        // 填充数据
        int rowNum = 1;
        for (Activity activity : activities) {
            Row row = sheet.createRow(rowNum++);
            // 设置活动编号为纯数字格式，不使用科学计数法
            Cell activityIdCell = row.createCell(0);
            activityIdCell.setCellValue(activity.getActivityId());
            CellStyle numericStyle = workbook.createCellStyle();
            numericStyle.setDataFormat(workbook.createDataFormat().getFormat("0"));  // 设置为纯数字格式，不使用科学计数法
            activityIdCell.setCellStyle(numericStyle);

            row.createCell(1).setCellValue(activity.getLeaderName());
            row.createCell(2).setCellValue(activity.getActivityName());
            row.createCell(3).setCellValue(activity.getLocation());

            // 保留开始时间的原始数值格式
            Cell startTimeCell = row.createCell(4);
            startTimeCell.setCellValue(activity.getStartTime().toString());

            row.createCell(5).setCellValue(activity.getMemberName());
            row.createCell(6).setCellValue(sharedMoney);
        }

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        // 准备HTTP响应
        byte[] excelData = outputStream.toByteArray();
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        responseHeaders.setContentDispositionFormData("attachment", "activities.xlsx");
        responseHeaders.setContentLength(excelData.length);
        return new ResponseEntity<>(excelData, responseHeaders, HttpStatus.OK);
    }



    // 内部类用于接收前端发送的JSON数据
    private static class RequestData {
        private String username;
        private Long activityId;

        public String getUsername() {
            return username;
        }
        public Long getActivityId() {
            return activityId;
        }
        public void setUsername(String username) {
            this.username = username;
        }
        public void setActivityId(Long activityId) {
            this.activityId = activityId;
        }
    }
}
