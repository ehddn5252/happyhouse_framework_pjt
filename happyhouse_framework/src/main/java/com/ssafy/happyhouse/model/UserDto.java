package com.ssafy.happyhouse.model;

// DTO : Data Transfer Object
// VO : Value Object

public class UserDto {

	private String userId;
	private String userPwd;
	private String userEmail;
	private String userName;
	private String userBirth;
	private String userGender;
	private String registDate;
	private String manager;
	private String userPhoneNum;

	public String getUserGender() {
		return userGender;
	}


	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getUserPwd() {
		return userPwd;
	}


	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}


	public String getUserEmail() {
		return userEmail;
	}


	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getUserBirth() {
		return userBirth;
	}


	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}


	public String getRegistDate() {
		return registDate;
	}


	public void setRegistDate(String registDate) {
		this.registDate = registDate;
	}
	public String getManager() {
		return manager;
	}


	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getUserPhoneNum() {
		return userPhoneNum;
	}
	
	
	public void setUserPhoneNum(String phoneNum) {
		this.userPhoneNum = phoneNum;
	}

	@Override
	public String toString() {
		return userId + "\t" + userPwd + "\t" + userName + "\t"  + userBirth + "\t" + userGender
				+ "\t" + userEmail+ "\t" + registDate;
	}

}
