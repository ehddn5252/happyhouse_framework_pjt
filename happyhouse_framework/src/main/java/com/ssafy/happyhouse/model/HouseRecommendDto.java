package com.ssafy.happyhouse.model;

public class HouseRecommendDto {
	private int aptCode;
	private String aptName;
	private float recentPrice;
	private float buildYear;
	private String dongName;
	private String sidoName;
	private String gugunName;
	public int getAptCode() {
		return aptCode;
	}
	public void setAptCode(int aptCode) {
		this.aptCode = aptCode;
	}
	public String getAptName() {
		return aptName;
	}
	public void setAptName(String aptName) {
		this.aptName = aptName;
	}
	public float getRecentPrice() {
		return recentPrice;
	}
	public void setRecentPrice(float recentPrice) {
		this.recentPrice = recentPrice;
	}
	public float getBuildYear() {
		return buildYear;
	}
	public void setBuildYear(float buildYear) {
		this.buildYear = buildYear;
	}
	public String getDongName() {
		return dongName;
	}
	public void setDongName(String dongName) {
		this.dongName = dongName;
	}
	public String getSidoName() {
		return sidoName;
	}
	public void setSidoName(String sidoName) {
		this.sidoName = sidoName;
	}
	public String getGugunName() {
		return gugunName;
	}
	public void setGugunName(String gugunName) {
		this.gugunName = gugunName;
	}
}
