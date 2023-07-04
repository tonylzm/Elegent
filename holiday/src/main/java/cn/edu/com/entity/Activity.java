package cn.edu.com.entity;
// Activity.java

import java.util.Date;

public class Activity {
    private long activityId;
    private String leaderName;
    private String activityName;
    private String location;
    private Date startTime;
    private int capacity;
    private double duration;
    private double money;
    private double lng;
    private double lat;
    private String memberName;



    // Getters and Setters
    public double getLng() {
        return lng;
    }
    public double getLat() {
        return lat;
    }
    public double getMoney() {
        return money;
    }
    public double getDuration() {
        return duration;
    }
public void setLng(double lng) {
        this.lng = lng;
    }
    public void setLat(double lat) {
        this.lat = lat;
    }
    public void setMoney(double money) {
        this.money = money;
    }
    public void setDuration(double duration) {
        this.duration = duration;
    }
    public long getActivityId() {
        return activityId;
    }

    public void setActivityId(long activityId) {
        this.activityId = activityId;
    }

    public String getLeaderName() {
        return leaderName;
    }

    public void setLeaderName(String leaderName) {
        this.leaderName = leaderName;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getMemberName() {
        return memberName;
    }
    public void setMemberName(String memberName) {
        this.memberName=memberName;
    }
}
