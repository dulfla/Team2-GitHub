package spring.business;

import java.util.ArrayList;
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
import spring.vo.CountByCategory;
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
		
		int[] memberAdminYears = (int[])admin.get("memberAdminYears");
		
		String[] typeY = {"allMember", "joinMember", "withdrawMember"};
		Object[] countByYear = {admin.get("countAllMemberYear"), admin.get("countJoinMemberYear"), admin.get("countWithdrawMemberYear")};
		String countByYearJson = to_json("countByYear", memberAdminYears, typeY, countByYear);
		
		String[] typeM = {"joinMember", "withdrawMember"};
		Object[] countByMonths = {admin.get("joinMonths"), admin.get("withdrawMonths")};
		String countByMonthsJson = to_json("countByMonths", memberAdminYears, typeM, countByMonths);
		
		JSONObject contYJ = (JSONObject) parser.parse(countByYearJson);
		JSONObject contMJ = (JSONObject) parser.parse(countByMonthsJson);
		
		jsonArr.add(contYJ);
		jsonArr.add(contMJ);
		
		json.put("memberAdmin", jsonArr);
		
		return json;
	}

	public JSONObject productAdmin() throws ParseException {
		Map<String, Object> admin = getProductAdminData();
		
		String[] types = {"inProd", "tradeProd", "outProd"};
		
		long[] productAdminType = (long[])admin.get("totalPieType");
		String productAdminTypeJson = to_json("productAdminType", types, productAdminType);
		
		Object[] prodCategorys = {admin.get("inByCategory"), admin.get("tradeByCategory"), admin.get("outByCategory")};
		String productAdminCategoryJson = to_json("productAdminCategory", types, prodCategorys);
		
		JSONObject pTypeJ = (JSONObject) parser.parse(productAdminTypeJson);
		JSONObject pCatgryJ = (JSONObject) parser.parse(productAdminCategoryJson);
		
		jsonArr.add(pTypeJ);
		jsonArr.add(pCatgryJ);
		
		json.put("memberAdmin", jsonArr);
		
		return json;
	}

	private String to_json(String type, String[] types, Object[] prodCategorys) {
		String json = String.format("{\"%s\":[{\"type\":[", type);
		for(int i=0; i<types.length; i++) {
			json += types[i];
			if(i!=types.length-1) {json += ", ";}
		}
		json += "]}, {\"date\":[";
		for(int i=0; i<prodCategorys.length; i++) {
			json += prodCategorys[i];
			if(i!=prodCategorys.length-1) {json += ", ";}
		}
		return json+"]}]}";
	}

	private String to_json(String type, String[] types, long[] prodType) {
		String json = String.format("{\"%s\":[{\"type\":[", type);
		for(int i=0; i<types.length; i++) {
			json += types[i];
			if(i!=types.length-1) {json += ", ";}
		}
		json += "]}, {\"date\":[";
		for(int i=0; i<prodType.length; i++) {
			json += prodType[i];
			if(i!=prodType.length-1) {json += ", ";}
		}
		return json+"]}]}";
	}

	private String to_json(String type, int[] memberAdminYears, String[] types, Object[] counts) {
		String json = String.format("{\"%s\":[{\"years\":[", type);
		for(int y=0; y<memberAdminYears.length; y++) {
			if(y!=0) { json += ", "; }
			json += memberAdminYears[y];
		}
		json += "]}, {\"type\":[";
		for(int t=0; t<types.length; t++) {
			if(t!=0) { json += ", "; }
			json += types[t];
		}
		json += "]}, {\"data\":[";
		if(counts.length==3) { // year
			for(int c=0; c<counts.length; c++) {
				List<CountByYearVo> count = (List<CountByYearVo>)counts[c];
				json += "[";
				for(int sc=0; sc<memberAdminYears.length; sc++) {
					if(memberAdminYears[sc]==Integer.parseInt(count.get(sc).getYear())) {
						json += count.get(sc).getCnt();
					}else {
						json += 0;
						sc--;
					}
					if(sc<memberAdminYears.length) { json += ", "; }
				}
				json += "]";
				if(c!=0) { json += ", "; }
			}
		}else if(counts.length==2){ // month
			for(int c=0; c<counts.length; c++) {
				List<CountByMonthVo> count = (List<CountByMonthVo>)counts[c];
				json += "[";
				for(int sc=0, s=0; sc<memberAdminYears.length; sc++) {
					for(int m=1; m<=12 && s<count.size(); m++) {
						if(memberAdminYears[sc]==Integer.parseInt(count.get(m).getYear())) {
							if(m!=1) { json += ", "; }
							if(Integer.parseInt(count.get(c).getMonth())!=m) {
								json += 0;
							}else {
								json += count.get(c).getCnt();
								s++;
							}
						}else {
							break;
						}
					}
				}
				json += "]";
				if(c!=0) { json += ", "; }
			}
		}
		return json+"]}]}";
	}

	private Map<String, Object> getMemberAdminData() {
		Map<String, Object> admin = new HashMap<>();
		
		List<String> memAminYear = dao.memberAdminYears();
		int[] memberAdminYears = new int[Integer.parseInt(memAminYear.get(memAminYear.size()-1))-Integer.parseInt(memAminYear.get(0))+1];
		for(int i=0, y=Integer.parseInt(memAminYear.get(0)); i<=memberAdminYears.length; i++) {
			memberAdminYears[i] = y+i;
		}
		
		List<CountByYearVo> countAllMemberYear = dao.countAllMemberYear();
		
		List<CountByYearVo> countJoinMemberYear = dao.countMemberYear("IN");
		List<CountByYearVo> countWithdrawMemberYear = dao.countMemberYear("OUT");
		
		List<CountByMonthVo> joinMonths = dao.countMemberMonth("IN");
		List<CountByMonthVo> withdrawMonths = dao.countMemberMonth("OUT");
		
		admin.put("memberAdminYears", memberAdminYears);
		admin.put("countAllMemberYear", countAllMemberYear);
		admin.put("countJoinMemberYear", countJoinMemberYear);
		admin.put("countWithdrawMemberYear", countWithdrawMemberYear);
		admin.put("joinMonths", joinMonths);
		admin.put("withdrawMonths", withdrawMonths);
		
		return admin;
	}
	
	private Map<String, Object> getProductAdminData() {
		Map<String, Object> admin = new HashMap();
		
		long[] productAdminType = {dao.countAllTypeProduct("IN"), dao.countAllTypeProduct("TRADE"), dao.countBfTradeRemovedProduct()};
		
		List<CountByCategory> inProd = dao.countAllTypeProductByCategory("IN");
		List<CountByCategory> tradeProd = dao.countAllTypeProductByCategory("TRADE");
		List<CountByCategory> outProd = dao.countBfTradeRemovedProductByCategory();
		
		admin.put("totalPieType", productAdminType);
		admin.put("inByCategory", inProd);
		admin.put("tradeByCategory", tradeProd);
		admin.put("outByCategory", outProd);
		
		return admin;
	}
	
}
