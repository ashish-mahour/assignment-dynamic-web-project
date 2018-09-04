package com.adwb.config;

import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableTransactionManagement
@Configuration
@ComponentScan(basePackages= {"com.adwb"})
@PropertySource(value = "classpath:application.properties")
public class HibernateConfig {
	@Autowired
	Environment environment;
	
	@Bean
	public DataSource getDataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		
		dataSource.setDriverClassName(environment.getRequiredProperty("jdbc.driver"));
		dataSource.setUrl(environment.getRequiredProperty("jdbc.url"));
		dataSource.setUsername(environment.getRequiredProperty("jdbc.username"));
		dataSource.setPassword(environment.getRequiredProperty("jdbc.password"));
		
		return dataSource;
	}
	
	private Properties getHibernateProperties() {
		Properties p = new Properties();
		p.setProperty("hibernate.dialect", environment.getRequiredProperty("hibernate.dialect"));
		p.setProperty("hibernate.show_sql", environment.getRequiredProperty("hibernate.show_sql"));
		p.setProperty("hibernate.format_sql", environment.getRequiredProperty("hibernate.format_sql"));
		p.setProperty("hibernate.hbm2ddl.auto", environment.getRequiredProperty("hibernate.hbm2ddl.auto"));
		return p;
	}
	
	@Bean
	public LocalSessionFactoryBean getSession() {
		LocalSessionFactoryBean localSessionFactoryBean = new LocalSessionFactoryBean();
		localSessionFactoryBean.setDataSource(getDataSource());
		localSessionFactoryBean.setHibernateProperties(getHibernateProperties());
		localSessionFactoryBean.setPackagesToScan("com.adwb.dao.entity");
		return localSessionFactoryBean;
	}
	
	@Bean
	@Autowired
	public HibernateTransactionManager getTransaction(SessionFactory s) {
		HibernateTransactionManager hibernateTransactionManager = new HibernateTransactionManager();
		hibernateTransactionManager.setSessionFactory(s);
		return hibernateTransactionManager;
	}
	
	
}
