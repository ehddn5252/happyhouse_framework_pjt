package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.RegionDto;

public interface InterestMapper {
	
	void deleteInterest(int interestID);
	
	List<RegionDto> searchById(String userid);
	
}
