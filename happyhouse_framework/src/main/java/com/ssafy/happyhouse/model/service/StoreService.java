package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.EnvDto;
import com.ssafy.happyhouse.model.StoreDto;
import com.ssafy.happyhouse.model.StoreParamDto;

public interface StoreService {
	public List<StoreDto> searchByCodes(StoreParamDto storeParam);
	public List<EnvDto> searchAll(String code);
}
