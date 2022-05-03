package com.ssafy.happyhouse.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.UserDto;
import com.ssafy.happyhouse.model.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper userMapper;
	

	@Override
	public int idCheck(String id) throws Exception {
		return userMapper.idCheck(id);
	}
	
	@Override
	public void register(UserDto userDto) throws Exception {
		userMapper.register(userDto);
	}

	@Override
	public UserDto login(Map<String, String> map) throws Exception {
		return userMapper.login(map);
	}

	@Override
	public void updateUser(UserDto userDto) throws Exception {
		userMapper.updateUser(userDto);
	}
	

	@Override
	public void deleteUser(String id) throws Exception {
		userMapper.deleteUser(id);
	}

	/*
	 * @Override public UserDto searchById(String id) throws Exception { return
	 * userMapper.searchById(id); }
	 */
	
	@Override
	public String searchPwdById(String id) throws Exception {
		return userMapper.searchPwdById(id);
	}


}
