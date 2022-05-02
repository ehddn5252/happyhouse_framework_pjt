package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.ListParameterDto;
import com.ssafy.happyhouse.model.UserDto;
import com.ssafy.happyhouse.model.mapper.UserDao;
import com.ssafy.happyhouse.model.mapper.UserDaoImpl;
import com.ssafy.util.PageNavigation;

public class UserServiceImpl implements UserService {
	
	private UserDao userDao = UserDaoImpl.getUserDao();
	
	private static UserService userService = new UserServiceImpl();
	
	private UserServiceImpl() {}

	public static UserService getUserService() {
		return userService;
	}

	@Override
	public int idCheck(String id) {
		return userDao.idCheck(id);
	}
	
	@Override
	public void registerMember(UserDto userDto) throws Exception {
		userDao.register(userDto);
	}

	@Override
	public UserDto login(String id, String pass) throws Exception {
		return userDao.login(id, pass);
	}

	@Override
	public void updateMember(UserDto userDto) throws Exception {
		userDao.updateInfo(userDto);
	}
	
	@Override
	public void updatePwd(String userId, String userPwd) throws Exception {
		userDao.updatePwd(userId, userPwd);
	}

	@Override
	public void deleteMember(String id) throws Exception {
		userDao.deleteUser(id);
	}

	@Override
	public UserDto infoMember(String id) throws Exception {
		return userDao.searchById(id);
	}
	
	@Override
	public String searchPwdById(String id) throws Exception {
		return userDao.searchPwdById(id);
	}

	
	
	@Override
	public PageNavigation makePageNavigation(String pg, String key, String word) throws Exception {
		PageNavigation pageNavigation = new PageNavigation();
		int currentPage = pg != null ? Integer.parseInt(pg) : 1;
		int naviSize = 5;
		int countPerPage = 10;
		pageNavigation.setCurrentPage(currentPage);
		pageNavigation.setCountPerPage(countPerPage);
		pageNavigation.setNaviSize(naviSize);
		
		ListParameterDto listParameterDto = new ListParameterDto();
		listParameterDto.setKey(key == null ? "" : key.trim());
		listParameterDto.setWord(word == null ? "" : word.trim());
		
		int totalCount = userDao.getTotalCount(listParameterDto);
		pageNavigation.setTotalCount(totalCount);
		int totalPageCount = (totalCount - 1) / countPerPage + 1;
		pageNavigation.setTotalPageCount(totalPageCount);
		pageNavigation.setStartRange(currentPage <= naviSize);
		boolean endRange = (totalPageCount - 1) / naviSize * naviSize < currentPage;
		pageNavigation.setEndRange(endRange);
		pageNavigation.makeNavigator();
		return pageNavigation;
	}

	@Override
	public List<UserDto> userList(String pg, String key, String word) throws Exception {
		int pgno = pg != null ? Integer.parseInt(pg) : 1;
		int countPerPage = 10;
		int start= (pgno - 1) * countPerPage;
		
		ListParameterDto listParameterDto = new ListParameterDto();
		listParameterDto.setKey(key == null ? "" : key.trim());
		listParameterDto.setWord(word == null ? "" : word.trim());
		listParameterDto.setStart(start);
		listParameterDto.setCurrentPerPage(countPerPage);
		return userDao.searchAll(listParameterDto);
	}

}
