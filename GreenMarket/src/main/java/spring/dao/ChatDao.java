package spring.dao;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import spring.vo.ChatMessageVo;
import spring.vo.ChattingRoomBringingCommand;
import spring.vo.ChattingRoomInfoListVo;

public class ChatDao {

	private SqlSession sqlSesison;
	public ChatDao(SqlSession sqlSesison) {
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

	public Collection<ChattingRoomInfoListVo> selectChattingRoomByPId(String p_id) {
		return sqlSesison.selectList("mybatis.mapper.chat.selectChattingRoomByPId", p_id);
	}

	public int insertMessage(ChatMessageVo msgVo) {
		return sqlSesison.insert("mybatis.mapper.chat.insertMessage", msgVo);
	}

	public ChatMessageVo selectSendedMessage(long idx) {
		return sqlSesison.selectOne("mybatis.mapper.chat.selectSendedMessage", idx);
	}

	public Collection<ChattingRoomInfoListVo> selectChattingRoomByEmail(String email) {
		return sqlSesison.selectList("mybatis.mapper.chat.selectAllChatRoomByEmil", email);
	}
	
}
