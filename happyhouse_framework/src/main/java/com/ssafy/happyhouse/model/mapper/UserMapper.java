package com.ssafy.happyhouse.model.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.UserDto;

@Mapper
public interface UserMapper {
	
	// 중복확인
	int idCheck(String id) throws Exception;
	// 회원가입
	void register(UserDto userDto) throws Exception;
	// 로그인
	UserDto login(Map<String, String> map) throws Exception;
	// 탈퇴
	void deleteUser(String userId) throws Exception;
	// 회원정보 수정
	void updateUser(UserDto userDto) throws Exception;
	// 회원 정보 조회
	/* UserDto searchById(String userId) throws Exception; */
	// 아이디로 비번 찾기
	String searchPwdById(String userId) throws Exception;
//	// 전체 회원 데이터 출력
//	List<UserDto> searchAll(ListParameterDto listParameterDto) throws Exception;
//	// 총 회원 수
//	int getTotalCount(ListParameterDto listParameterDto) throws Exception;
}
