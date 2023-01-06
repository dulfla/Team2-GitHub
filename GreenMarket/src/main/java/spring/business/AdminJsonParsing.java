package spring.business;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import spring.dao.AdminDao;
import spring.vo.CountVo;

public class AdminJsonParsing {

	public JSONObject memverAdmin(AdminDao a_dao) {
		// https://velog.io/@jwpark06/Java-JSON-%EB%8B%A4%EB%A3%A8%EA%B8%B0
		// https://codechacha.com/ko/java-parse-json/
		
		List<CountVo> join = a_dao.countAllJoinMember();
		List<CountVo> withdraw = a_dao.countAllWithdrawMember();
		
		for(int i=0; i<join.size(); i++) {
			System.out.println("년도"+join.get(i).getYear());
			System.out.println("월"+join.get(i).getMonth());
			System.out.println("카운트"+join.get(i).getCnt());
		}
		
		JSONObject countJson = new JSONObject();
		
		JSONArray joinCountList = new JSONArray();
		JSONObject year = new JSONObject();
		year.put(join.get(0).getYear(), 'a');
		
		JSONArray withdrawCountList = new JSONArray();
		
		
		countJson.put("joinCountList", joinCountList);
		countJson.put("withdrawCountList", withdrawCountList);
		
		return null;
	}

	
	
}
