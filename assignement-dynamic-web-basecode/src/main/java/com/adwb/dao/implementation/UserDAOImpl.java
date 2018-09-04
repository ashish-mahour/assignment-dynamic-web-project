package com.adwb.dao.implementation;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.adwb.dao.api.UserDAO;
import com.adwb.dao.entity.UserData;

@Repository
public class UserDAOImpl implements UserDAO{
	
	
	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public void insert(UserData userData) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.persist(userData);
		session.getTransaction().commit();
		session.close();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserData> getAllData() {
		
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		List<UserData> userDatas = session.createQuery("from UserData").list();
		session.getTransaction().commit();
		session.close();
		return userDatas;
	}

	@Override
	public UserData getOne(int id) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		UserData userData = (UserData) session.find(UserData.class, id);
		session.getTransaction().commit();
		session.close();
		return userData;
	}

}
