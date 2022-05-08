package com.ssafy.happyhouse.controller;

import java.sql.SQLException;
import java.util.List;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;





// CrossOrigin("localhost:8080") 은 해당 사용자만 사용할 수 있게 한다.
@Controller
@CrossOrigin("*")
public class UserInterestController2 {

	// 관심지역 등록 : /interest/register
	// 실거래가 조회 : /apart
	@GetMapping("/interest/register")
	public String moveInterest2() throws Exception {
		return "addInterest";
	}
	
	@GetMapping("/store")
	public String moveStore() throws Exception {
		return "store";
	}
}