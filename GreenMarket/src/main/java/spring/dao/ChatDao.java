package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.ChatInfomationVo;

public class ChatDao {

	private SqlSession sqlSession;
	public ChatDao(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<ChatInfomationVo> selectAllChatRoomInfo(String email){
		return sqlSession.selectList("mybatis.mapper.chat.selectAllChatRoomByEmil", email);
	}
	
}
