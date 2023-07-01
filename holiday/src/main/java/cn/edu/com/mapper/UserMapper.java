package cn.edu.com.mapper;

import cn.edu.com.dao.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper {
    @Insert("INSERT INTO users (username, password) VALUES (#{user.username}, #{user.password})")
    void insertUser(@Param("user") User user);

    @Select("SELECT * FROM users WHERE id = #{id}")
    User getUserById(@Param("id") Long id);

    @Select("SELECT * FROM users WHERE username = #{username}")
    User getUserByUsername(@Param("username") String username);
}
