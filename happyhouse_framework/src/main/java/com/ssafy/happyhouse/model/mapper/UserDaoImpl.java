package com.ssafy.happyhouse.model.mapper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ssafy.happyhouse.model.ListParameterDto;
import com.ssafy.happyhouse.model.UserDto;
import com.ssafy.util.DBUtil;

//DAO : DataBase Access Object
public class UserDaoImpl implements UserDao {
	private DBUtil dbUtil = DBUtil.getInstance();

private static UserDao userDao = new UserDaoImpl();
	
	private UserDaoImpl() {}

	public static UserDao getUserDao() {
		return userDao;
	}
	
	@Override
	public int idCheck(String id) {
		int cnt = 1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder loginMember = new StringBuilder();
			loginMember.append("select count(userid) \n");
			loginMember.append("from user \n");
			loginMember.append("where userId = ?");
			pstmt = conn.prepareStatement(loginMember.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			cnt = 1;
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
		return cnt;
	}
	
	@Override
	public void register(UserDto userInfoDto) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "insert into user \r\n"
					+ "values (?, ?, ?, ?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userInfoDto.getUserId());
			pstmt.setString(2, userInfoDto.getUserPwd());
			pstmt.setString(3, userInfoDto.getUserName());
			pstmt.setString(4, userInfoDto.getUserBirth());
			pstmt.setString(5, userInfoDto.getUserGender());
			pstmt.setString(6, userInfoDto.getUserEmail());
			pstmt.setString(7, userInfoDto.getRegistDate());
			pstmt.setString(8, userInfoDto.getManager());
			pstmt.setString(9, userInfoDto.getUserPhoneNum());
//			LocalDate.now()
			System.out.println(pstmt);
			pstmt.executeUpdate();
		} finally {
			dbUtil.close(pstmt, conn);
		}
	}
	
	@Override
	public void updatePwd(String userId, String userPwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "update user ";
			sql += "set userPassword = ? ";
			sql += "where userId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userPwd);
			pstmt.setString(2, userId);
			System.out.println(pstmt);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void deleteUser(String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "delete from user where userId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public UserDto searchById(String userInfoId) {
		UserDto userInfoDto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "select userId, userPassword, userEmail, userName, ";
			sql += "date_format(userBirth, '%Y-%m-%d') userBirth, userGender, date_format(registDate, '%Y-%m-%d') registDate, manager, phoneNum \n";
			sql += "from user \n";
			sql += "where userId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userInfoId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userInfoDto = new UserDto();
				userInfoDto.setUserId(rs.getString("userId"));
				userInfoDto.setUserPwd(rs.getString("userPassword"));
				userInfoDto.setUserEmail(rs.getString("userEmail"));
				userInfoDto.setUserName(rs.getString("userName"));
				userInfoDto.setUserBirth(rs.getString("userBirth"));
				userInfoDto.setRegistDate(rs.getString("registDate"));
				userInfoDto.setUserGender(rs.getString("userGender"));
				userInfoDto.setManager(rs.getString("manager"));
				userInfoDto.setUserPhoneNum(rs.getString("phoneNum"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(conn, pstmt, rs);
		}
		return userInfoDto;
	}

	@Override
	public String searchPwdById(String userId) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String pwd = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "select userPassword ";
			sql += "from user \n";
			sql += "where userId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				pwd = rs.getString("userPassword");
			}
		} finally {
			dbUtil.close(conn, pstmt, rs);
		}
		return pwd;
	}

	@Override
	public List<UserDto> searchAll(ListParameterDto listParameterDto) throws SQLException {
		List<UserDto> list = new ArrayList<UserDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder listArticle = new StringBuilder();
			listArticle.append("select g.articleno, g.userid, g.subject, g.content, m.username,  \n");
			listArticle.append(" 		case when date_format(g.regtime, '%y%m%d') = date_format(now(), '%y%m%d') \n");
			listArticle.append("			then date_format(g.regtime, '%H:%i:%d') \n");
			listArticle.append("			else date_format(g.regtime, '%y.%m.%d') \n");
			listArticle.append("		end regtime \n");
			listArticle.append("from guestbook g, ssafy_member m \n");
			listArticle.append("where g.userid = m.userid \n");
			String key = listParameterDto.getKey();
			String word = listParameterDto.getWord();
			if(!word.isEmpty()) {
				if(key.equals("subject")) {
					listArticle.append("and g.subject like concat('%', ?, '%') \n");
				} else {
					listArticle.append("and g." + key + " = ? \n");
				}
			}
			listArticle.append("order by g.articleno desc limit ?, ? \n");
			pstmt = conn.prepareStatement(listArticle.toString());
			int idx = 0;
			if(!word.isEmpty()) {
				pstmt.setString(++idx, word);
			}
			pstmt.setInt(++idx, listParameterDto.getStart());
			pstmt.setInt(++idx, listParameterDto.getCurrentPerPage());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserDto userDto = new UserDto();
				userDto.setUserId(rs.getString("userId"));
				userDto.setUserPwd(rs.getString("userPassword"));
				userDto.setUserEmail(rs.getString("userEmail"));
				userDto.setUserName(rs.getString("userName"));
				userDto.setUserBirth(rs.getString("userBirth"));
				userDto.setRegistDate(rs.getString("registDate"));
				userDto.setUserGender(rs.getString("userGender"));
				userDto.setUserGender(rs.getString("manager"));
				
				list.add(userDto);
			}
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
		return list;
	}
	
	@Override
	public int getTotalCount(ListParameterDto listParameterDto) throws SQLException {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder listArticle = new StringBuilder();
			listArticle.append("select count(userId) \n");
			listArticle.append("from user \n");
			String key = listParameterDto.getKey();
			String word = listParameterDto.getWord();
			if(!word.isEmpty()) {
				if(key.equals("subject")) {
					listArticle.append("where subject like concat('%', ?, '%') \n");
				} else {
					listArticle.append("where " + key + " = ? \n");
				}
			}

			pstmt = conn.prepareStatement(listArticle.toString());
			if(!word.isEmpty())
				pstmt.setString(1, word);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
		return cnt;
	}
	
	@Override
	public UserDto login(String id, String pass) throws SQLException {
		UserDto userDto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder sb = new StringBuilder();
			sb.append("select userId, userName, manager \n");
			sb.append("from user \n");
			sb.append("where userId = ? and userPassword = ? \n");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userDto = new UserDto();
				userDto.setUserId(rs.getString("userid"));
				userDto.setUserName(rs.getString("username"));
				userDto.setUserName(rs.getString("manager"));
			}
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
		return userDto;
	}

	@Override
	public void updateInfo(UserDto userDto) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder updateArticle = new StringBuilder();
			updateArticle.append("update user \n");
			updateArticle.append("set userName = ?, userEmail = ?, phoneNum = ? \n");
			updateArticle.append("where userId = ?");
			pstmt = conn.prepareStatement(updateArticle.toString());
			pstmt.setString(1, userDto.getUserName());
			pstmt.setString(2, userDto.getUserEmail());
			pstmt.setString(3, userDto.getUserPhoneNum());
			pstmt.setString(4, userDto.getUserId());
			pstmt.executeUpdate();
		} finally {
			dbUtil.close(pstmt, conn);
		}
	}

}
