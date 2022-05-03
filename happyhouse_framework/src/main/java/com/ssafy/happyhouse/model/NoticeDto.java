package com.ssafy.happyhouse.model;

import java.sql.Timestamp;



public class NoticeDto {
	
	private int noticeID;
	private String noticeTitle;
	private String noticeContent;
	private String userID;
	private Timestamp noticeDate;
	
	

	
	public int getNoticeID() {
		return noticeID;
	}
	public void setNoticeID(int noticeID) {
		this.noticeID = noticeID;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public Timestamp getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(Timestamp noticeDate) {
		this.noticeDate = noticeDate;
	}
	
	
	@Override
	public String toString() {
		return "NoticeDto [noticeID=" + noticeID + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", userID=" + userID + ", noticeDate=" + noticeDate + "]";
	}
	
	
	

}
