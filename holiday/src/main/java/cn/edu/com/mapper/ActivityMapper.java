package cn.edu.com.mapper;// ActivityMapper.java

import cn.edu.com.dao.Activity;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ActivityMapper {
    @Insert("INSERT INTO activity (activityId, leaderName, activityName, location, startTime, capacity) " +
            "VALUES (#{activityId}, #{leaderName}, #{activityName}, #{location}, #{startTime}, #{capacity})")
    void insertActivity(Activity activity);
    @Select("SELECT * FROM activity WHERE leaderName = #{username}")
    List<Activity>getActivitiesByUsername(String username);



}
