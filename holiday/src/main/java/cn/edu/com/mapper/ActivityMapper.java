package cn.edu.com.mapper;// ActivityMapper.java

import cn.edu.com.entity.Activity;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ActivityMapper {
    @Insert("INSERT INTO activity (activityId, leaderName, activityName, location, startTime, capacity,Duration,money,lng,lat) " +
            "VALUES (#{activityId}, #{leaderName}, #{activityName}, #{location}, #{startTime}, #{capacity},#{duration},#{money},#{lng},#{lat})")
    void insertActivity(Activity activity);
    @Insert("INSERT INTO member (activityId, membername)\n" +
            "SELECT #{activityId}, #{username}\n" +
            "FROM DUAL\n" +
            "WHERE NOT EXISTS (SELECT 1 FROM member WHERE activityId = #{activityId} AND membername = #{username});\n")
    void joinActivity(@Param("activityId") long activityId, @Param("username") String username);


    @Select("SELECT * FROM activity WHERE leaderName = #{username}")
    List<Activity>getActivitiesByUsername(String username);
    @Select("SELECT * FROM activity WHERE leaderName <> #{username}")
    List<Activity>addActivity(String username);
    @Select("SELECT * FROM activity WHERE activityId = #{activityId}")
    List<Activity>getActivityById(long activityId);
    @Select(" SELECT m.membername, a.activityId, a.activityName, a.money,a.leaderName,a.location,a.startTime\n" +
            "FROM member m, activity a\n" +
            "WHERE m.activityId = a.activityId AND m.activityId = #{activityId};")
    List<Activity> getMemberById(long activityId);
    @Select("SELECT * FROM activity WHERE activityid IN (\n" +
            "  SELECT activityid FROM member WHERE membername = #{username}\n" +
            ");")
    List<Activity> getJoinActivities(String username);
    @Select("SELECT activity.*, member.membername\n" +
            "FROM activity\n" +
            "JOIN member ON activity.activityid = member.activityid\n" +
            "WHERE activity.leadername = #{username};\n")
    List<Activity> manage(String username);






    @Delete("DELETE FROM activity WHERE activityId = #{activityId}")
    void deleteActivityById(long activityId);
    @Delete("DELETE FROM member WHERE activityId = #{activityId} AND membername = #{username}")
    void QuitTeam(@Param("activityId") long activityId, @Param("username") String username);




    @Update("UPDATE activity SET leaderName = #{leaderName}, activityName = #{activityName}, location = #{location}, startTime = #{startTime}, capacity = #{capacity} ,duration=#{duration},money=#{money}WHERE activityId = #{activityId}")
    void updateActivity(Activity activity);




}
