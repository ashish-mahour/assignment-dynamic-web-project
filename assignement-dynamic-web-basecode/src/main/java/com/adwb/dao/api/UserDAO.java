package com.adwb.dao.api;

import java.util.List;

import com.adwb.dao.entity.UserData;

public interface UserDAO {
	public void insert(UserData userData);
	public List<UserData> getAllData();
	public UserData getOne(int id);
}
