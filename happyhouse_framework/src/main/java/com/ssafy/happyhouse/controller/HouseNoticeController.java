package com.ssafy.happyhouse.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.service.HouseNoticeService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@Controller
@RequestMapping("/notice")
public class HouseNoticeController {
	private final Logger logger = LoggerFactory.getLogger(HouseNoticeController.class);

	@Autowired
	private HouseNoticeService service;
	
	
	
	@GetMapping("/id")
	public String noticeId(@RequestParam("noticeID") int id, Model model) {
		
		model.addAttribute("nview",service.noticeDetail(id));
		return "noticeSelect";
	}
	
	
	
	@GetMapping
	public String notice(Model model) {
		model.addAttribute("nlist",service.findAll());
		return "notice";
	}
	
	@PostMapping
	public @ResponseBody String notice(@RequestBody NoticeDto notice) {
		service.noticeRegist(notice);
		logger.info("{zdsadasdsd",notice);
		return "ok";
	}
	
	
	
	@PutMapping
	public @ResponseBody String noticeUpdate(@RequestBody NoticeDto notice) {
		service.noticeUpdate(notice);
		logger.info(notice+"Ttt11111111st");
		return "notice";
	}
	
	
	@DeleteMapping
	public @ResponseBody String notice(@RequestParam("noticeID") int id) {	
		service.noticeDelete(id);
		return "redirect:/";
	}
	
	@GetMapping("/register")
	public String register() {
		return "addNotice";
	}
	
	
	
	
	
	
}
