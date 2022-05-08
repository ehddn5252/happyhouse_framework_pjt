package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.LatLngParamDto;

@Mapper
public interface BestAptMapper {
	List<HouseInfoDto> searchBestApt(LatLngParamDto latlng) throws SQLException;
}
