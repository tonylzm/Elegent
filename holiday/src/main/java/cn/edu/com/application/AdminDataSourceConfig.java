package cn.edu.com.application;

import com.github.pagehelper.PageHelper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.omg.PortableInterceptor.Interceptor;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@MapperScan(basePackages = "cn.edu.com.dao",sqlSessionTemplateRef  = "adminSqlSessionTemplate")
public class AdminDataSourceConfig {

    @Bean(name = "adminDataSource")
    @ConfigurationProperties(prefix = "spring.datasource")
    @Primary
    public DataSource adminDataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "adminSqlSessionFactory")
    @Primary
    public SqlSessionFactory adminSqlSessionFactory(@Qualifier("adminDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(dataSource);
        //分页插件
        PageHelper pageHelper = new PageHelper();
   Properties props = new Properties();
//        props.setProperty("reasonable", "true");
//        props.setProperty("supportMethodsArguments", "true");
//        props.setProperty("returnPageInfo", "check");
//        props.setProperty("params", "count=countSql");
//        pageHelper.setProperties(props);
        //添加插件
        bean.setPlugins(new Interceptor[]{pagePlugin});
        // 添加mybatis配置文件
        bean.setConfigLocation(new DefaultResourceLoader().getResource("classpath:mybatis/mybatis-config.xml"));
        // 添加mybatis映射文件
        bean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mybatis/system/*.xml"));
        return bean.getObject();
    }

    @Bean(name = "adminTransactionManager")
    @Primary
    public DataSourceTransactionManager adminTransactionManager(@Qualifier("adminDataSource") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

    @Bean(name = "adminSqlSessionTemplate")
    @Primary
    public SqlSessionTemplate adminSqlSessionTemplate(@Qualifier("adminSqlSessionFactory") SqlSessionFactory sqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}