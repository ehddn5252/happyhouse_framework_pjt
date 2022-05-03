package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.RegionDto;
import com.ssafy.happyhouse.model.mapper.InterestMapMapper;

@Service
public class InterestMapServiceImpl implements InterestMapService {
	
	@Autowired
	private InterestMapMapper interestMapMapper;
	
	// 관심지역 등록
	@Override
	public void insertInterest(RegionDto interestDto) throws Exception{
		System.out.println("interestDto");
		System.out.println(interestDto.toString());
		System.out.println("========");
		
		interestMapMapper.insertInterest(interestDto);
		System.out.println("완료");
		
	}

	@Override
	public void deleteInterest(int interestID) throws Exception {
		// TODO Auto-generated method stub
	}
	
	@Override
	public List<RegionDto> searchByUserID(String userid) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * // 관심지역 삭제
	 * 
	 * @Override public void deleteInterest(int interestID) throws SQLException{
	 * interestMapMapper.deleteInterest(interestID); return ; };
	 * 
	 * @Override public List<RegionDto> searchByUserID(String userid) throws
	 * SQLException { interestMapMapper.searchByUserID(userid); return null; }
	 */

	
}
