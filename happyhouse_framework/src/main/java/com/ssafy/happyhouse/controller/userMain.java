package com.ssafy.happyhouse.controller;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
		logger.debug("userDto info : {}", userDto);
		userService.register(userDto);
		return "redirect:/user/login";
	}
	
	@GetMapping("/idcheck")
	public @ResponseBody String idCheck(@RequestParam("ckid") String checkId) throws Exception {
		int idCount = userService.idCheck(checkId);
		JSONObject json = new JSONObject();
		json.put("idcount", idCount);
		return json.toString();
	}
	
	
	@PostMapping("/login")
	public String login(@RequestParam Map<String, String> map, Model model, HttpSession session,
			HttpServletResponse response) throws Exception {
		logger.debug("map : {}", map.get("userId"));
		UserDto UserDto = userService.login(map);
		if (UserDto != null) {
			session.setAttribute("userinfo", UserDto);

			Cookie cookie = new Cookie("ssafy_id", map.get("userId"));
			cookie.setPath("/");
			if ("saveok".equals(map.get("idsave"))) {
				cookie.setMaxAge(60 * 60 * 24 * 365 * 40);
			} else {
				cookie.setMaxAge(0);
			}
			response.addCookie(cookie);
			return "redirect:/";
		} else {
			model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 다시 로그인하세요!");
			return "user/login";
		}
	}
	
	// 로그아웃하면, index.jsp로 이동
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 마이페이지로 이동
	@PostMapping("/userinfo")
	public ModelAndView userinfo(String userId) throws Exception {
		ModelAndView mav = new ModelAndView();
		UserDto UserDto = userService.searchById(userId);
		mav.addObject("userDto", UserDto);
		mav.setViewName("register");
		return mav;
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
	@DeleteMapping(value = "/user/{userid}")
	public String userDelete(@RequestBody String userId, HttpSession session) throws Exception {
		userService.deleteUser(userId);
		session.invalidate();
		return "redirect:/";
	}
	
	
	
//	@ApiOperation(value = "회원정보수정", notes = "회원정보를 수정합니다.")
//	@PutMapping(value = "/user")
//	public ResponseEntity<?> userModify(@RequestBody UserDto userDto) {
//		try {
//			userService.updateUser(userDto);
//			return new ResponseEntity<List<UserDto>>(list, HttpStatus.OK);
//		} catch (Exception e) {
//			return exceptionHandling(e);
//		}
//	}
	
	
//	private ResponseEntity<String> exceptionHandling(Exception e) {
//		e.printStackTrace();
//		return new ResponseEntity<String>("Error : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
//	}

}
