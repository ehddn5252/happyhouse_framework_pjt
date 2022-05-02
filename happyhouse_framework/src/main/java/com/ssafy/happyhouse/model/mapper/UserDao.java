package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.ListParameterDto;
import com.ssafy.happyhouse.model.UserDto;


public interface UserDao {
	
	// 중복확인
	int idCheck(String id);
	// 회원가입
	void register(UserDto userDto) throws SQLException;
	// 로그인
	UserDto login(String id, String pwd) throws SQLException;
	// 탈퇴
	void deleteUser(String userId) throws SQLException;
	// 비밀번호 변경
	void updateInfo(UserDto userDto) throws SQLException;
	// 비밀번호 변경
	void updatePwd(String userId, String userPwd) throws SQLException;
	// 회원 정보 조회
	UserDto searchById(String userId) throws SQLException;
	// 아이디로 비번 찾기
	String searchPwdById(String userId) throws SQLException;
	// 전체 회원 데이터 출력
	List<UserDto> searchAll(ListParameterDto listParameterDto) throws SQLException;
	// 총 회원 수
	int getTotalCount(ListParameterDto listParameterDto) throws SQLException;
}
