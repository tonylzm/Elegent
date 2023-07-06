package cn.edu.com.mapper;

import cn.edu.com.entity.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper {
    @Insert("INSERT INTO user (username, password, account) VALUES (#{user.username}, #{user.password}, #{user.account})")
    void insertUser(@Param("user") User user);


    @Select("SELECT * FROM users WHERE id = #{id}")
    User getUserById(@Param("id") Long id);

    @Select("SELECT * FROM user WHERE username = #{username}")
    User getUserByUsername(@Param("username") String username);
}
