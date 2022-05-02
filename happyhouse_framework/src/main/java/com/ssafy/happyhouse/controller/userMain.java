<<<<<<< HEAD
package com.ssafy.controller;
=======
package com.ssafy.happyhouse.controller;
>>>>>>> 47a06e094dd4904cc223c58ed290809fb02e457c

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ssafy.dto.UserDto;
import com.ssafy.service.UserService;
import com.ssafy.service.UserServiceImpl;
import com.ssafy.util.PageNavigation;

@WebServlet("/user")
public class userMain extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	
	private UserService userService = UserServiceImpl.getUserService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String act = request.getParameter("act");
		String path = "/index.jsp";
		if("mvregister".equals(act)) {
			response.sendRedirect(request.getContextPath() + "/register.jsp");
		} else if("mvError".equals(act)) {
			response.sendRedirect(request.getContextPath() + "/error/error.jsp");
		} else if("mvfindpwd".equals(act)) {
			response.sendRedirect(request.getContextPath() + "/findPwd.jsp");
		} else if("mvmypage".equals(act)) {
			path = getUser(request, response);
			request.getRequestDispatcher(path).forward(request, response);
		} else if("mvModifyPwd".equals(act)) {
			response.sendRedirect(request.getContextPath() + "/modifyPwd.jsp");
		} else if("register".equals(act)) {
			int state = registerMember(request, response);
			// 정상적으로 회원가입시 1, 아니면 0
			if (state==1) {
				response.sendRedirect(request.getContextPath() + "/index.jsp");
			} else {
				path = "/error/error.jsp";
				request.getRequestDispatcher(path).forward(request, response);
			}
		} else if("idcheck".equals(act)) {
			int cnt = idCheck(request, response);
			response.getWriter().append(cnt + "");
		} else if("findpwd".equals(act)) {
			response.setCharacterEncoding("UTF-8");
			String msg = findPwd(request, response);
			response.getWriter().append(msg + "");
		} else if("userinfo".equals(act)) {
			path = getUser(request, response);
			request.getRequestDispatcher(path).forward(request, response);
		} else if("login".equals(act)) {
			String state = loginMember(request, response);
			response.getWriter().append(state + "");
		}else if("logout".equals(act)) {
			path = logoutUser(request, response);
			response.sendRedirect(path);
		} else if ("list".equals(act)) {
			path = searchAllUser(request, response);
			request.getRequestDispatcher(path).forward(request, response);
		}  else if ("modify".equals(act)) {
			path = updateUser(request, response);
			response.sendRedirect(path);
		} else if ("modifypwd".equals(act)) {
			String msg = updatePwd(request, response);
			response.getWriter().append(msg + "");
		}else if ("delete".equals(act)) {
			path = deleteUser(request, response);
			response.sendRedirect(path);
		}
	}

	private String findPwd(HttpServletRequest request, HttpServletResponse response) {

		String id = request.getParameter("userid");
		
		try {
			String pwd = userService.searchPwdById(id);
			if (pwd!=null) {
				return id+"님의 비밀번호는 "+pwd+"입니다.";
			} else {
				return "해당 회원은 존재하지 않습니다.";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "글목록 얻기중 에러가 발생했습니다.");
			return "에러";
		}
	}

	private String searchAllUser(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserDto userDto = (UserDto) session.getAttribute("userInfo");
		// 관리자모드일 때만 조회가능
		if(userDto.getManager() == "manager") {
			String pg = request.getParameter("pg");
			String key = request.getParameter("key");
			String word = request.getParameter("word");
			try {
				List<UserDto> list = userService.userList(pg, key, word);
				PageNavigation navigation = userService.makePageNavigation(pg, key, word);
				
				request.setAttribute("articles", list);
				request.setAttribute("navi", navigation);
				request.setAttribute("key", key);
				request.setAttribute("word", word);
				
				return "/guestbook/list.jsp";
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("msg", "글목록 얻기중 에러가 발생했습니다.");
				return "/error/error.jsp";
			}
		} else {			
			return "/user?act=mvlogin";
		}
	}

	private String updateUser(HttpServletRequest request, HttpServletResponse response) {
		UserDto userDto = new UserDto();
		userDto.setUserId(request.getParameter("userId"));
		userDto.setUserName(request.getParameter("userName"));
		userDto.setUserEmail(request.getParameter("userEmail"));
		userDto.setUserPhoneNum(request.getParameter("userPhoneNum"));
		try {
			userService.updateMember(userDto);
			return "user?act=mvmypage";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "글 수정중 에러가 발생했습니다.");
			return "error/error.jsp";
		}
	}
	
	private String updatePwd(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserDto userdto = (UserDto) session.getAttribute("userInfo");
		String userId = userdto.getUserId();
		String newpwd = request.getParameter("newpwd");
		String ckpwd = request.getParameter("ckpwd");
		System.out.println(userId);
		System.out.println(newpwd);
		try {
			userService.updatePwd(userId, newpwd);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "글 수정중 에러가 발생했습니다.");
			return "error";
		}
	}

	private String deleteUser(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("userId");
		try {
			userService.deleteMember(id);
			return logoutUser(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "글 얻기중 에러가 발생했습니다.");
			return "error/error.jsp";
		}
	}

	private int idCheck(HttpServletRequest request, HttpServletResponse response) {
		int cnt = 1;
		String id = request.getParameter("ckid");
		cnt = userService.idCheck(id);
		return cnt;
	}

	private int registerMember(HttpServletRequest request, HttpServletResponse response) {
		UserDto userDto = new UserDto();
		userDto.setUserName(request.getParameter("name"));
		userDto.setUserId(request.getParameter("id"));
		userDto.setUserPwd(request.getParameter("password"));
		userDto.setUserBirth(request.getParameter("birth"));
		userDto.setUserGender(request.getParameter("gender"));
		userDto.setUserEmail(request.getParameter("email"));
		userDto.setUserPhoneNum(request.getParameter("phonenum"));
		userDto.setRegistDate(LocalDate.now().toString());
		userDto.setManager("user");
		try {
			userService.registerMember(userDto);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "회원 가입 중 문제가 발생했습니다.");
			return 0;
		}
	}
	
	// 로그인 성공하면 1, 아니면 0, 오류뜨면 -1
	private String loginMember(HttpServletRequest request, HttpServletResponse response) {
		UserDto userDto = null;
		String id = request.getParameter("userid");
		String pass = request.getParameter("userpwd");
		
		try {
			userDto = userService.login(id, pass);
			if(userDto != null) { // 로그인 성공
//				session setting
				HttpSession session = request.getSession();
				session.setAttribute("userInfo", userDto);
				
				String idsv = request.getParameter("idsave");
				if("saveok".equals(idsv)) { // 아이디 저장 체크
	//				Cookie setting
					Cookie cookie = new Cookie("loginid", id);
					cookie.setMaxAge(60*60*24*365*20);
					cookie.setPath(request.getContextPath());
					
					response.addCookie(cookie);
				} else { // 아이디 저장 체크 X
					Cookie[] cookies = request.getCookies();
					if(cookies != null) {
						for(int i=0;i<cookies.length;i++) {
							if(cookies[i].getName().equals("loginid")) {
								cookies[i].setMaxAge(0);
								response.addCookie(cookies[i]);
								break;
							}
						}
					}
				}
				
				return "1";
			} else { // 로그인 실패
				return "0";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "로그인 처리중 문제 발생!!";
		}
	}

	private String logoutUser(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.invalidate();
		System.out.println("로그아웃");
		return "index.jsp";
	}
	
	
	private String getUser(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session =  request.getSession();
		UserDto loginUserDto = (UserDto)session.getAttribute("userInfo");
		String userId = loginUserDto.getUserId();	
		
		try {
			UserDto userDto = userService.infoMember(userId);
			request.setAttribute("userInfo", userDto);
			return "myPage.jsp";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "글 얻기중 에러가 발생했습니다.");
			return "/error/error.jsp";
		}
		
	}
}
