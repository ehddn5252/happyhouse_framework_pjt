package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.LatLngParamDto;

public interface BestAptService {
	List<HouseInfoDto> searchBestApt(LatLngParamDto latlng) throws SQLException;
}
