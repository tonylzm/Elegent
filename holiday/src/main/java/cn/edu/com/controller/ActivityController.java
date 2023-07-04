package cn.edu.com.controller;

import cn.edu.com.entity.Activity;
import cn.edu.com.service.ActivityService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
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
    @PostMapping(value = "/exportActivitiesToExcel", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public ResponseEntity<byte[]> exportActivitiesToExcel(@RequestBody RequestData requestData) throws IOException {
        // 查询数据库获取对应用户名下的活动列表
        String username = requestData.getUsername();
        List<Activity> activities = activityService.getActivitiesByUsername(username);
        // 创建Excel工作簿和工作表
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Activities");

        // 创建表头
        String[] headers = {"Activity ID", "Leader Name", "Activity Name", "Location", "Start Time", "Capacity"};
        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        // 填充数据
        int rowNum = 1;
        for (Activity activity : activities) {
            Row row = sheet.createRow(rowNum++);

            row.createCell(0).setCellValue(activity.getActivityId());
            row.createCell(1).setCellValue(activity.getLeaderName());
            row.createCell(2).setCellValue(activity.getActivityName());
            row.createCell(3).setCellValue(activity.getLocation());
            row.createCell(4).setCellValue(activity.getStartTime());
            row.createCell(5).setCellValue(activity.getCapacity());
        }

        // 将Excel数据写入字节数组输出流
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
