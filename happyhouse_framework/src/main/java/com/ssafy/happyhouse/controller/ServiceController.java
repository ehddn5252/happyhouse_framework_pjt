package com.ssafy.happyhouse.controller;

import java.sql.SQLException;

import java.util.List;

import org.apache.coyote.http11.Http11AprProtocol;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.LatLngParamDto;
import com.ssafy.happyhouse.model.StoreDto;
import com.ssafy.happyhouse.model.service.BestAptService;

@Controller
@RequestMapping("/service")
public class ServiceController {
	
	private final Logger logger = LoggerFactory.getLogger(ServiceController.class);
	
	@Autowired
	BestAptService bestAptServ;
	
	@GetMapping("/best")
	public String interest(){
		return "serviceBest";
	}
	
	@PostMapping("/getApt")
	@ResponseBody
	public ResponseEntity<List<HouseInfoDto>> getApt(@RequestBody LatLngParamDto latlng) throws SQLException {
		System.out.println(latlng.toString());
		return new ResponseEntity<List<HouseInfoDto>>(bestAptServ.searchBestApt(latlng),HttpStatus.OK);
	}


}
