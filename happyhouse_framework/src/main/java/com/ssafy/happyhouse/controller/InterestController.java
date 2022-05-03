package com.ssafy.happyhouse.controller;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.RegionDto;
import com.ssafy.happyhouse.model.service.InterestService;

@Controller
@CrossOrigin("*")
@RequestMapping("/interest")
public class InterestController {
	
	private final Logger logger = LoggerFactory.getLogger(HouseMapController.class);

	@Autowired
	public InterestService interService; 
	
	@GetMapping("/list")
	public String interest(){
		return "interest";
	}
	
	@GetMapping("/list/{id}")
	@ResponseBody
	public ResponseEntity<List<RegionDto>> interestList(@PathVariable("id") String userid) throws SQLException {
		return new ResponseEntity<List<RegionDto>>(interService.searchByUserID(userid),HttpStatus.OK);
	}
	
	@DeleteMapping("/list/{id}/{interestId}")
	public ResponseEntity<List<RegionDto>> interestDelete(@PathVariable("interestId") int interestId,@PathVariable("id") String userid) throws SQLException {
		interService.deleteInterest(interestId);
		return new ResponseEntity<List<RegionDto>>(interService.searchByUserID(userid),HttpStatus.OK);
	}
	
	
}
