package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.RegionDto;
import com.ssafy.happyhouse.model.mapper.InterestMapper;


@Service
public class InterestServiceImpl implements InterestService {
	
	@Autowired
	public InterestMapper interestMapper;

	@Override
	public void insertInterest(RegionDto interestDto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteInterest(int interestID) throws SQLException {
		interestMapper.deleteInterest(interestID);
		
	}

	@Override
	public List<RegionDto> searchByUserID(String userid) throws SQLException {
		return interestMapper.searchById(userid);
	}

}
