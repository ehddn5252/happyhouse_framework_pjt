package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;

public interface HouseMapService {

	List<SidoGugunCodeDto> getSido() throws Exception;
	List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception;
	List<HouseInfoDto> getDongInGugun(String gugun) throws Exception;
	List<HouseInfoDto> getAptInDong(String dong) throws Exception;
    List<HouseInfoDto> getAptInName(String aptName, String dong) throws Exception;
    List<HouseInfoDto> getDongList(String gugun) throws SQLException;
    List<HouseInfoDto> getLngLat(String dongName) throws SQLException;
 	
}
