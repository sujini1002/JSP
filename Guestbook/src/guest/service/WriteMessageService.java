package guest.service;

import java.sql.Connection;
import java.sql.SQLException;

import JDBCtest.ConnectionProvider;
import JDBCtest.JdbcUtil;
import guest.dao.MessageDao;
import guest.model.Message;


public class WriteMessageService {
	private static WriteMessageService service = new WriteMessageService();

	public static WriteMessageService getInstance() {
		return service;
	}

	private WriteMessageService() {
		
	}

	public void write(Message message) throws ServiceException  {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			
			MessageDao messageDao = MessageDao.getInstance();
			
			messageDao.insert(conn, message);
		} catch (SQLException e) {
			throw new ServiceException("메시지 등록 실패: " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		} 
	}
}
