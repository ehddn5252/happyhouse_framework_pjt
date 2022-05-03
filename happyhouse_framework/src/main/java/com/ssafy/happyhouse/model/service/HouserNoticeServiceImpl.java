package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.mapper.NoticeMapper;

@Service
public class HouserNoticeServiceImpl implements HouseNoticeService{

	
	@Autowired
	private NoticeMapper mapper;
	
	@Override
	public List<NoticeDto> findAll() {
		// TODO Auto-generated method stub
		return mapper.findAll();
	}

	@Override
	public void noticeRegist(NoticeDto notice) {
	
		mapper.noticeRegist(notice);
		// TODO Auto-generated method stub
		
	}

	@Override
	public NoticeDto noticeDetail(int noticeID) {
		return mapper.noticeDetail(noticeID);
	}

	@Override
	public void noticeDelete(int noticeID) {
		mapper.noticeDelete(noticeID);
		
	}

	@Override
	public void noticeUpdate(NoticeDto notice) {
		mapper.noticeUpdate(notice);
		
	}

}
