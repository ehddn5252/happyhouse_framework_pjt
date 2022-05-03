package com.ssafy.happyhouse.controller;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.RegionDto;
import com.ssafy.happyhouse.model.service.HouseMapService;
import com.ssafy.happyhouse.model.service.InterestMapService;


// CrossOrigin("localhost:8080") 은 해당 사용자만 사용할 수 있게 한다.
@RestController
@RequestMapping("")
@CrossOrigin("*")
public class UserInterestController {
	
	private final Logger logger = LoggerFactory.getLogger(UserInterestController.class);

	@Autowired
	private InterestMapService interestService;

	/*
	 * @GetMapping("/interest") public ResponseEntity<List<RegionDto>>
	 * searchByUserID(@RequestParam("userid") String userid) throws SQLException{
	 * return new
	 * ResponseEntity<List<RegionDto>>(interestService.searchByUserID(userid),
	 * HttpStatus.OK); }
	 */

	@PostMapping("/interest/insert")
	public void insertInterest(@RequestBody RegionDto r) throws Exception{
		System.out.println("in UserInterestController");
		logger.debug(r.getUserId()+" "+r.getSidoCode()+" "+r.getSigugunCode()+" "+r.getDongCode());

		interestService.insertInterest(r);
	}

	/*
	 * @DeleteMapping("/interest") public void deleteInterest(int interestID) throws
	 * Exception{ logger.debug("delete:{}",interestID);
	 * interestService.deleteInterest(interestID); }
	 */
}
