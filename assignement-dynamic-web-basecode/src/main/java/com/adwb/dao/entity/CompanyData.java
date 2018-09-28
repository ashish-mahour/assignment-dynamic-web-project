package com.adwb.dao.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "company_data")
public class CompanyData {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	private String compName;
	private String compAddress;
	private int creatorId;
	private String creatorName;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getCompAddress() {
		return compAddress;
	}
	public void setCompAddress(String compAddress) {
		this.compAddress = compAddress;
	}
	public int getCreatorId() {
		return creatorId;
	}
	public void setCreatorId(int creatorId) {
		this.creatorId = creatorId;
	}
	public String getCreatorName() {
		return creatorName;
	}
	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
	public CompanyData(int id, String compName, String compAddress, int creatorId, String creatorName) {
		super();
		this.id = id;
		this.compName = compName;
		this.compAddress = compAddress;
		this.creatorId = creatorId;
		this.creatorName = creatorName;
	}
}
