package com.ssafy.happyhouse.controller;

import java.time.LocalDate;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.UserDto;
import com.ssafy.happyhouse.model.service.UserService;

@Controller
@RequestMapping("/user")
public class userMain  {
	
	private static final Logger logger = LoggerFactory.getLogger(userMain.class);
	
	@Autowired
	private UserService userService;

	@GetMapping("/register")
	public String register() {
		return "register";
	}
	
	@PostMapping("/register")
	public String register(UserDto userDto, Model model) throws Exception {
		userDto.setManager("user");
		userDto.setRegistDate(LocalDate.now().toString());
		logger.debug("userDto info : {}", userDto);
		userService.register(userDto);
		return "redirect:/";
	}
	
	@GetMapping("/idcheck")
	public @ResponseBody String idCheck(@RequestParam("ckid") String checkId) throws Exception {
		int idCount = userService.idCheck(checkId);
		JSONObject json = new JSONObject();
		json.put("idcount", idCount);
		return json.toString();
	}
	
	
	@PostMapping("/login")
	public @ResponseBody String login(@RequestParam Map<String, String> map, Model model, HttpSession session,
			HttpServletResponse response) throws Exception {
		logger.debug("map : {}", map);
		UserDto UserDto = userService.login(map);
		if (UserDto != null) {
			session.setAttribute("userInfo", UserDto);

			Cookie cookie = new Cookie("ssafy_id", map.get("userId"));
			cookie.setPath("/");
			if ("true".equals(map.get("idsave"))) {
				cookie.setMaxAge(60 * 60 * 24 * 365 * 40);
			} else {
				cookie.setMaxAge(0);
			}
			response.addCookie(cookie);
			return "1";
		} else {
			model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 다시 로그인하세요!");
			return "0";
		}
	}
	
	// 로그아웃하면, index.jsp로 이동
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 마이페이지로 이동
	@GetMapping("/userinfo")
	public String userinfo() throws Exception {
//		ModelAndView mav = new ModelAndView();
//		UserDto UserDto = userService.searchById(userId);
//		mav.addObject("userDto", UserDto);
//		mav.setViewName();
		return "myPage";
	}
	
	
	// 비밀번호 찾기로 이동
	@GetMapping("/findpwd")
	public String findpwd() {
		return "findPwd";
	}
	
	
	// 비밀번호 수정으로 이동
	@GetMapping("/modifypwd")
	public String modifypwd() {
		return "modifyPwd";
	}
	
	// 마이페이지로 이동
	@DeleteMapping(value = "/delete/{userId}")
	public @ResponseBody String userDelete(@PathVariable String userId, HttpSession session) throws Exception {
		logger.debug("[delete] userId info : {}", userId);
		userService.deleteUser(userId);
		session.invalidate();
		
		JSONObject json = new JSONObject();
		json.put("status", "성공적으로 삭제.");
		return json.toString();
	}
	
	@PutMapping(value = "/modify")
	public @ResponseBody String userModify(@RequestBody UserDto userDto, HttpSession session) throws Exception {
		System.out.println("수정");
		logger.debug("[modify] userDto info : {}", userDto.toString());
		userService.updateUser(userDto);
		session.setAttribute("userInfo", userDto);
		
		JSONObject json = new JSONObject();
		json.put("status", "성공적으로 변경했습니다");
		System.out.println("변경성공");
		return json.toString();
	}
	
	@PostMapping(value = "/findpwd/{userId}")
	public @ResponseBody String searchPwdById(@PathVariable String userId) throws Exception {
		logger.debug("[delete] userId info : {}", userId);
		String userPwd=userService.searchPwdById(userId);
		JSONObject json = new JSONObject();
		if (userPwd==null) {
			json.put("msg", "해당 회원이 존재하지 않습니다.");
		} else {
			json.put("msg", userId+"님의 비밀번호는 "+userPwd+"입니다.");
		}
		return json.toString();
	}
	

}
