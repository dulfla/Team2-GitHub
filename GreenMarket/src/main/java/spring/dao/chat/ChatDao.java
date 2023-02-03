package spring.dao.chat;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import spring.vo.chat.ChatMessageVo;
import spring.vo.chat.ChatProductInfoVo;
import spring.vo.chat.ChattingRoomBringingCommand;
import spring.vo.chat.ChattingRoomInfoListVo;
import spring.vo.product.ProductImageVO;
import spring.vo.product.ProductListVO;

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

	public ChatProductInfoVo selectProductByChatRoomId(String c_id) {
		return sqlSesison.selectOne("mybatis.mapper.chat.selectProductByChatRoomId", c_id);
	}

	public ProductImageVO selectProductImg(String p_id) {
		return sqlSesison.selectOne("mybatis.mapper.chat.selectProductImg", p_id);
	}

	public String selectNickNameByEmail(String email) {
		return sqlSesison.selectOne("mybatis.mapper.chat.selectNicknameByEmil", email);
	}

	public void readAllMessage(ChatMessageVo message) {
		sqlSesison.selectOne("mybatis.mapper.chat.readAllMessage", message);
	}

	public void readThisMessage(ChatMessageVo message) {
		sqlSesison.selectOne("mybatis.mapper.chat.readThisMessage", message);
	}

	public void saveWebsocketSession(Map<String, String> info) {
		sqlSesison.insert("mybatis.mapper.chat.saveWebsocket", info);
	}

	public void removeWebsocketSession(Map<String, String> info) {
		sqlSesison.delete("mybatis.mapper.chat.removeWebsocket", info);
	}

	public void removeAllWebsocketSession() {
		sqlSesison.delete("mybatis.mapper.chat.removeAllWebsocket");
	}

	public List<String> selectEmailInChatRoom(String c_id) {
		return sqlSesison.selectList("mybatis.mapper.chat.selectChatJoinMembers", c_id);
	}

	public List<String> selectSessionIdByThis(Map<String, String> check) {
		return sqlSesison.selectList("mybatis.mapper.chat.selectSessionIdByThis", check);
	}
	
}
