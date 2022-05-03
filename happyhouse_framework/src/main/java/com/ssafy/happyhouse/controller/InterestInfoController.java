package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.EnvDto;
import com.ssafy.happyhouse.model.StoreDto;
import com.ssafy.happyhouse.model.StoreParamDto;
import com.ssafy.happyhouse.model.service.StoreService;

@Controller
@CrossOrigin("*")
@RequestMapping("/interestinfo")
public class InterestInfoController {
	
	@Autowired
	public StoreService storeService;
	
	@GetMapping("/env")
	public String envPage() {
		return "env";
	}
	
	@GetMapping("/store")
	public String storePage() {
		return "store";
	}
	
	@GetMapping(value="/env/search/{code}")
	@ResponseBody
	public ResponseEntity<List<EnvDto>> searchEnvByCode(@PathVariable("code") String code){
		String sidogun = code.substring(0, 5);
		return new ResponseEntity<List<EnvDto>>(storeService.searchAll(sidogun),HttpStatus.OK);
	}
	
	
	@GetMapping(value="/store/search/{regionCode}")
	@ResponseBody
	public ResponseEntity<List<StoreDto>> searchStore(@PathVariable("regionCode")String regionCode){
		StoreParamDto storeParam = new StoreParamDto(regionCode);
		return new ResponseEntity<List<StoreDto>>(storeService.searchByCodes(storeParam),HttpStatus.OK);
	}
	
	@GetMapping(value="/store/searchByCode/{regionCode}/codes/{codes}")
	@ResponseBody
	public ResponseEntity<List<StoreDto>> searchStoreByCode(@PathVariable("regionCode")String regionCode, @PathVariable("codes")String[] codeList){
		StoreParamDto storeParam = new StoreParamDto(regionCode, codeList);
		return new ResponseEntity<List<StoreDto>>(storeService.searchByCodes(storeParam),HttpStatus.OK);
	}
}
