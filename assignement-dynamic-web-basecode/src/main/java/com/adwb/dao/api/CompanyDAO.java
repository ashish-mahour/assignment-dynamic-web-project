package com.adwb.dao.api;

import java.util.List;

import com.adwb.dao.entity.CompanyData;

public interface CompanyDAO {
	public void insert(CompanyData companyData);
	public void update(CompanyData companyData);
	public void delete(int id);
	public CompanyData getOne(int id);
	public List<CompanyData> getAll();
}
