package spring.dao;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import spring.vo.ChatMessageVo;
import spring.vo.ChattingRoomBringingCommand;

public class ChatDao {

	private SqlSession sqlSesison;
	public ChatDao(SqlSession sqlSesison) {
		super();
		this.sqlSesison = sqlSesison;
	}
	
	public String selectChattingRoom(ChattingRoomBringingCommand crbc) {
		return sqlSesison.selectOne("mybatis.mapper.chat.selectChattingRoom", crbc);
	}

	public String insertNewChatRoomInfo(ChattingRoomBringingCommand crbc) {
		sqlSesison.selectOne("mybatis.mapper.chat.insertNewChatRoomInfo", crbc);
		return crbc.getC_id();
	}

	public List<ChatMessageVo> selectAllMessagesInChatRoom(String c_id) {
		return sqlSesison.selectList("mybatis.mapper.chat.selectAllMessages", c_id);
	}
	
}
