package com.ssafy.happyhouse.model;

public class RegionDto {
	

	int interestId;
	String userId;
	String sidoCode;
	String sigugunCode;
	String dongCode;
	String areaName;

	
	public RegionDto() {}
	
	public RegionDto(String userId, String sidoCode, String sigugunCode, String dongCode, String areaName) {	
		this.userId = userId;
		this.sidoCode = sidoCode;
		this.sigugunCode = sigugunCode;
		this.dongCode = dongCode;
		this.areaName = areaName;
	}

	public int getInterestId() {
		return interestId;
	}
	public void setInterestId(int interestId) {
		this.interestId = interestId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSidoCode() {
		return sidoCode;
	}
	public void setSidoCode(String sidoCode) {
		this.sidoCode = sidoCode;
	}
	public String getSigugunCode() {
		return sigugunCode;
	}
	public void setSigugunCode(String sigugunCode) {
		this.sigugunCode = sigugunCode;
	}
	public String getDongCode() {
		return dongCode;
	}
	public void setDongCode(String dongCode) {
		this.dongCode = dongCode;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

}

