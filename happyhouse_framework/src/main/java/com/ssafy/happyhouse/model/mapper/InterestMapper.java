package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import com.ssafy.happyhouse.model.RegionDto;

public interface InterestMapper {
	public List<RegionDto> searchById(String userid);
}
