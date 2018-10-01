package member.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import jdbc.JdbcUtil;
import openProject.MemberInfo;

public class CrudDao {
	private static  CrudDao crudDao = new CrudDao();
	public static CrudDao getInstance() {
		return crudDao;
	}
	private CrudDao() {}
	
	//회원가입
	public int insert(Connection conn,MemberInfo member) throws SQLException {
		PreparedStatement pstmt  = null;
		try {
		pstmt = conn.prepareStatement("insert into members_mvc values(?,?,?,?)");
		
		pstmt.setString(1, member.getUserId());
		pstmt.setString(2, member.getUserPw());
		pstmt.setString(3, member.getUserName());
		pstmt.setString(4, member.getUserImg());
		
		return pstmt.executeUpdate();
		}finally {
			JdbcUtil.close(pstmt);
		}
	}
	//회원리스트 출력
	public List<MemberInfo> selectList(Connection conn) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement("select userid,username,userimg from members_mvc");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				List<MemberInfo> memberList = new ArrayList<MemberInfo>();
				do {
					memberList.add(MakeMember(rs));
				}while(rs.next());
				
				return memberList;
			}else {
				return Collections.emptyList();
			}
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
	}
	private MemberInfo MakeMember(ResultSet rs) throws SQLException {
		MemberInfo member = new MemberInfo();
		member.setUserId(rs.getString(1));
		member.setUserName(rs.getString(2));
		member.setUserImg(rs.getString(3));
		return member;
	}
	
}
