package com.ssafy.happyhouse.controller;

import java.util.List;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.HouseMapService;



// CrossOrigin("localhost:8080") 은 해당 사용자만 사용할 수 있게 한다.
@RestController
@RequestMapping("/apart/map")
@CrossOrigin("*")
public class HouseMapController {
	
	private final Logger logger = LoggerFactory.getLogger(HouseMapController.class);

	@Autowired
	private HouseMapService haHouseMapService;

	@GetMapping("/sido")
	public ResponseEntity<List<SidoGugunCodeDto>> sido() throws Exception {
		logger.debug("sido : {}", haHouseMapService.getSido());
		return new ResponseEntity<List<SidoGugunCodeDto>>(haHouseMapService.getSido(), HttpStatus.OK);
	}
	
	@GetMapping("/gugun")
	public ResponseEntity<List<SidoGugunCodeDto>> gugun(@RequestParam("sido") String sido) throws Exception {
		return new ResponseEntity<List<SidoGugunCodeDto>>(haHouseMapService.getGugunInSido(sido), HttpStatus.OK);
	}
	
	@GetMapping("/dong")
	public ResponseEntity<List<HouseInfoDto>> dong(@RequestParam("gugun") String gugun) throws Exception {
		return new ResponseEntity<List<HouseInfoDto>>(haHouseMapService.getDongInGugun(gugun), HttpStatus.OK);
	}
	
	@GetMapping("/apt")
	public ResponseEntity<List<HouseInfoDto>> apt(@RequestParam("dong") String dong) throws Exception {
		System.out.println("!!!!!!!!!");
		return new ResponseEntity<List<HouseInfoDto>>(haHouseMapService.getAptInDong(dong), HttpStatus.OK);
	}

	// 아파트 이름으로 찾기
	@GetMapping("/aptName")
	public ResponseEntity<List<HouseInfoDto>> aptName(@RequestParam("aptName") String aptName, @RequestParam("dong") String dong) throws Exception {
		
		return new ResponseEntity<List<HouseInfoDto>>(haHouseMapService.getAptInName(aptName, dong), HttpStatus.OK);
	}
	
	@GetMapping
	public ResponseEntity<List<HouseInfoDto>> dongList(@RequestParam("gugun") String gugun) throws Exception {
		return new ResponseEntity<List<HouseInfoDto>>(haHouseMapService.getDongInGugun(gugun), HttpStatus.OK);
	}
	
	
	
	
}
