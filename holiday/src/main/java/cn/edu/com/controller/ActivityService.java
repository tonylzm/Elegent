package cn.edu.com.controller;// ActivityService.java

import cn.edu.com.dao.Activity;
import cn.edu.com.mapper.ActivityMapper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

@Service
public class ActivityService {
    @Autowired
    private ActivityMapper activityMapper;

    public void saveActivity(Activity activity) {
        activityMapper.insertActivity(activity);
    }

    public List<Activity> getActivitiesByUsername(String username) {
        System.out.println(username);
        return activityMapper.getActivitiesByUsername(username);
    }
    public List<Activity> getActivitiesByActivityName(String username) {
        System.out.println(username);
        return activityMapper.getActivitiesByUsername(username);
    }


}
