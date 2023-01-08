package spring.business;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import spring.dao.AdminDao;
import spring.vo.CountByMonthVo;
import spring.vo.CountByYearVo;

@Component
@Service
public class AdminJsonParsing {
	
	@Autowired
	private AdminDao dao;
	@Autowired
	private JSONParser parser;
	@Autowired
	private JSONArray jsonArr;
	@Autowired
	private JSONObject json;

	public JSONObject memverAdmin() throws ParseException {		
		Map<String, Object> admin = getMemberAdminData();
		
		List<String> memberAdminYears = (List<String>)admin.get("memberAdminYears");
		List<CountByYearVo> countAllMemberYear = (List<CountByYearVo>)admin.get("countAllMemberYear");
		List<CountByYearVo> countJoinMemberYear = (List<CountByYearVo>)admin.get("countJoinMemberYear");
		List<CountByYearVo> countWithdrawMemberYear = (List<CountByYearVo>)admin.get("countWithdrawMemberYear");
		List<CountByMonthVo> joinMonths = (List<CountByMonthVo>)admin.get("joinMonths");
		List<CountByMonthVo> withdrawMonths = (List<CountByMonthVo>)admin.get("withdrawMonths");
		
		String adminYearJson = to_json("memberAdminYears", memberAdminYears);
		String memberJson = to_jsonY("countAllMemberYear", memberAdminYears, countAllMemberYear);
		String joinYearJson = to_jsonY("countJoinMemberYear", memberAdminYears, countJoinMemberYear);
		String withdrawYearJson = to_jsonY("countWithdrawMemberYear", memberAdminYears, countWithdrawMemberYear);
		String joinMonthJson = to_jsonM("joinMonths", memberAdminYears, joinMonths);
		String withdrawMonthJson = to_jsonM("withdrawMonths", memberAdminYears, withdrawMonths);
		
		JSONObject yearJ = (JSONObject) parser.parse(adminYearJson);
		JSONObject memberYJ = (JSONObject) parser.parse(memberJson);
		JSONObject joinYJ = (JSONObject) parser.parse(joinYearJson);
		JSONObject wdrawYJ = (JSONObject) parser.parse(withdrawYearJson);
		JSONObject joinMJ = (JSONObject) parser.parse(joinMonthJson);
		JSONObject wdrawMJ = (JSONObject) parser.parse(withdrawMonthJson);
		
		jsonArr.add(yearJ);
		jsonArr.add(memberYJ);
		jsonArr.add(joinYJ);
		jsonArr.add(wdrawYJ);
		jsonArr.add(joinMJ);
		jsonArr.add(wdrawMJ);
		
		json.put("memberAdmin", jsonArr);
		
		return json;
	}

	private String to_json(String type, List<String> adminYears) {
		String json = String.format("{\"%s\":[", type);
		for(int y=0, c=0; y<adminYears.size(); y++) {
			json += adminYears.get(y);
			if(y<adminYears.size()-1) { json += ", "; }
		}
		return json+"]}";
	}

	private String to_jsonY(String type, List<String> adminYears, List<CountByYearVo> count) {
		String json = String.format("{\"%s\":[", type);
		for(int y=0, c=0; y<adminYears.size(); y++, c++) {
			json += String.format("{\"year\":%s, \"count\":", adminYears.get(y));
			if(c<count.size() && count.get(c).getYear().equals(adminYears.get(y))) {
				json += count.get(c).getCnt();
			}else {
				json += 0;
				c--;
			}
			json += "}";
			if(y<adminYears.size()-1) { json += ", "; }
		}
		return json+"]}";
	}	

	private String to_jsonM(String type, List<String> adminYears, List<CountByMonthVo> count) {
		String json = String.format("{\"%s\":[{\"years\":[", type);
		for(int y=0; y<adminYears.size(); y++) {
			if(y!=0) {
				json += ", ";
			}
			json += adminYears.get(y);
		}
		json += "]}, [";
		for(int y=0, c=0; y<adminYears.size(); y++) {
			json += String.format("{\"year\":%s, \"count\":[", adminYears.get(y));
			for(int m=1; m<=12 && c<count.size(); m++) {
				if(count.get(c).getYear().equals(adminYears.get(y))) {
					if(m!=1) {
						json += ", ";
					}
					if(Integer.parseInt(count.get(c).getMonth())!=m) {
						json += 0;
					}else {
						json += count.get(c).getCnt();
						c++;
					}
				}else {
					break;
				}
			}
			json += "]}";
			if(y<adminYears.size()-1) {
				json += ", ";
			}
		}
		return json+"]]}";
	}

	private Map<String, Object> getMemberAdminData() {
		Map<String, Object> admin = new HashMap<>();
		
		List<String> memberAdminYears = dao.memberAdminYears();
		
		List<CountByYearVo> countAllMemberYear = dao.countAllMemberYear();
		List<CountByYearVo> countJoinMemberYear = dao.countJoinMemberYear();
		List<CountByYearVo> countWithdrawMemberYear = dao.countWithdrawMemberYear();
		
		List<CountByMonthVo> joinMonths = dao.countJoinMemberMonth();
		List<CountByMonthVo> withdrawMonths = dao.countWithdrawMemberMonth();
		
		admin.put("memberAdminYears", memberAdminYears);
		admin.put("countAllMemberYear", countAllMemberYear);
		admin.put("countJoinMemberYear", countJoinMemberYear);
		admin.put("countWithdrawMemberYear", countWithdrawMemberYear);
		admin.put("joinMonths", joinMonths);
		admin.put("withdrawMonths", withdrawMonths);
		
		return admin;
	}
	
}
