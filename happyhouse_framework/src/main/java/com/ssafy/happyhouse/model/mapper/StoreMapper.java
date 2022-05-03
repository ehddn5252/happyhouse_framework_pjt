package com.ssafy.happyhouse.model.mapper;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.EnvDto;
import com.ssafy.happyhouse.model.StoreDto;
import com.ssafy.happyhouse.model.StoreParamDto;

public interface StoreMapper {
	public List<StoreDto> searchByCodes(StoreParamDto storeParam);
	public List<EnvDto> searchAll(String code);
}
