package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.UserDto;
import com.ssafy.util.PageNavigation;

public interface UserService {

	int idCheck(String id);
	void registerMember(UserDto memberDto) throws Exception;
	UserDto login(String id, String pass) throws Exception;
	
//	구현해 보세요!!!
	void updateMember(UserDto memberDto) throws Exception;
	void updatePwd(String userId, String userPwd) throws Exception;
	void deleteMember(String id) throws Exception;
	UserDto infoMember(String id) throws Exception;
	List<UserDto> userList(String pg, String key, String word) throws Exception;
	public PageNavigation makePageNavigation(String pg, String key, String word) throws Exception;
	public String searchPwdById(String id) throws Exception;
	
}
