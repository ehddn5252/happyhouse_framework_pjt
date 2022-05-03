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

	@GetMapping("/interest1")
	public String moveInterest() throws Exception {
		return "interest";
	}
	

	@GetMapping("/interest2")
	public String moveInterest2() throws Exception {
		return "addInterest2";
	}
	
	@GetMapping("/store")
	public String moveStore() throws Exception {
		return "store";
	}
}