package com.adwb.dao.implementation;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.adwb.dao.api.CompanyDAO;
import com.adwb.dao.entity.CompanyData;

@Repository
public class CompanyDAOImpl implements CompanyDAO{
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void insert(CompanyData companyData) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.persist(companyData);
		session.getTransaction().commit();
		session.close();
	}

	@Override
	public void update(CompanyData companyData) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		session.merge(companyData);
		session.getTransaction().commit();
		session.close();
	}

	@Override
	public void delete(int id) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		CompanyData companyData = getOne(id);
		session.delete(companyData);
		session.getTransaction().commit();
		session.close();
	}

	@Override
	public CompanyData getOne(int id) {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		CompanyData companyData = session.find(CompanyData.class, id);
		session.getTransaction().commit();
		session.close();
		return companyData;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CompanyData> getAll() {
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		List<CompanyData> companyDatas = session.createQuery("from CompanyData").list();
		session.getTransaction().commit();
		session.close();
		return companyDatas;
	}
}
