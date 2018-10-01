package member.service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.rowset.serial.SerialException;

import jdbc.ConnectionProvider;
import jdbc.JdbcUtil;
import member.DAO.CrudDao;
import member.Exception.ServiceException;
import openProject.MemberInfo;

public class MemberRegService {
	//½Ì±ÛÅæ
	private static MemberRegService memberRegService = new MemberRegService();
	public static MemberRegService getInstance() {
		return memberRegService;
	}
	private MemberRegService() {};
	
	public void Register(MemberInfo member) throws ServiceException {
		Connection conn  = null;
		try {
			conn = ConnectionProvider.getConnection();
			CrudDao crudDao = CrudDao.getInstance();
			
			crudDao.insert(conn, member);
		}catch(SQLException e) {
			throw new ServiceException("È¸¿ø°¡ÀÔ½ÇÆÐ"+e.getMessage(), e);
		}finally {
			JdbcUtil.close(conn);
		}
	}
}
