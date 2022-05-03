package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.NoticeDto;

@Mapper
public interface NoticeMapper {
	List<NoticeDto> findAll();
	void noticeRegist(NoticeDto notice);
	NoticeDto noticeDetail(int noticeID);
	void noticeDelete(int noticeID);
	void noticeUpdate(NoticeDto notice);
}
