package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.LatLngParamDto;
import com.ssafy.happyhouse.model.mapper.BestAptMapper;


@Service
public class BestAptServiceImpl implements BestAptService {
	
	@Autowired
	BestAptMapper bestAptMapper;

	@Override
	public List<HouseInfoDto> searchBestApt(LatLngParamDto latlngList) throws SQLException {
		return bestAptMapper.searchBestApt(latlngList);
		
	}
	
}
