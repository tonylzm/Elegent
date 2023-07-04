package cn.edu.com.service;// ActivityService.java

import cn.edu.com.entity.Activity;
import cn.edu.com.mapper.ActivityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    public List<Activity> addActivity(String username) {
        System.out.println(username);
        return activityMapper.addActivity(username);
    }

    public void deleteActivityById(long activityId) {
        activityMapper.deleteActivityById(activityId);
    }

public void updateActivity(Activity activity) {
        activityMapper.updateActivity(activity);
    }

    public List<Activity> getActivityById(long activityId){
        return activityMapper.getActivityById(activityId);
    }

}
