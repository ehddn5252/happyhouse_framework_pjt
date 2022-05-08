package com.ssafy.happyhouse.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.HouseMapService;

// CrossOrigin("localhost:8080") 은 해당 사용자만 사용할 수 있게 한다.
@Controller
@CrossOrigin("*")
public class HouseMapController2 {
	@GetMapping("/apart")
	public String moveApart() throws Exception {
		return "apart";
	}
	
	@GetMapping("/sj")
	public String apart_sj() throws Exception {
		return "apart_sj2";
	}
}