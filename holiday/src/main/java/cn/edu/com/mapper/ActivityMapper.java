package cn.edu.com.mapper;// ActivityMapper.java

import cn.edu.com.entity.Activity;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ActivityMapper {
    @Insert("INSERT INTO activity (activityId, leaderName, activityName, location, startTime, capacity,Duration,money,lng,lat) " +
            "VALUES (#{activityId}, #{leaderName}, #{activityName}, #{location}, #{startTime}, #{capacity},#{duration},#{money},#{lng},#{lat})")
    void insertActivity(Activity activity);
    @Select("SELECT * FROM activity WHERE leaderName = #{username}")
    List<Activity>getActivitiesByUsername(String username);
    @Select("SELECT * FROM activity WHERE leaderName <> #{username}")
    List<Activity>addActivity(String username);
    @Select("SELECT * FROM activity WHERE activityId = #{activityId}")
    List<Activity>getActivityById(long activityId);

    @Delete("DELETE FROM activity WHERE activityId = #{activityId}")
    void deleteActivityById(long activityId);

    @Update("UPDATE activity SET leaderName = #{leaderName}, activityName = #{activityName}, location = #{location}, startTime = #{startTime}, capacity = #{capacity} ,duration=#{duration},money=#{money}WHERE activityId = #{activityId}")
    void updateActivity(Activity activity);




}
