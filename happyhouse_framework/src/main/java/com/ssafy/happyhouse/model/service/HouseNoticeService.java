package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.NoticeDto;

public interface HouseNoticeService {
	List<NoticeDto> findAll();
	void noticeRegist(NoticeDto notice);
	NoticeDto noticeDetail(int noticeID);
	void noticeDelete(int noticeID);
	void noticeUpdate(NoticeDto notice);
}
