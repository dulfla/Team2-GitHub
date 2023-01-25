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

import spring.dao.admin.AdminDao;
import spring.vo.admin.CountByCategory;
import spring.vo.admin.CountByMonthVo;
import spring.vo.admin.CountByYearVo;

@Component
@Service
public class AdminJsonParsing {
	
	@Autowired
	private AdminDao dao;
	
	@Autowired
	private JSONParser parser;
	
	private JSONArray jsonArr;
	private JSONObject json;

	public JSONObject memverAdmin() throws ParseException {		
		Map<String, Object> admin = getMemberAdminData();
		
		int[] memberAdminYears = (int[])admin.get("memberAdminYears");
		
		String[] typeY = {"allMember", "joinMember", "withdrawMember"};
		Object[] countByYear = {admin.get("countAllMemberYear"), admin.get("countJoinMemberYear"), admin.get("countWithdrawMemberYear")};
		String countByYearJson = to_json("countByYear", memberAdminYears, typeY, countByYear);
		
		String[] typeM = {"joinMember", "withdrawMember"};
		Object[] countByMonths = {admin.get("joinMonths"), admin.get("withdrawMonths")};
		String countByMonthsJson = to_json("withdrawMonths", memberAdminYears, typeM, countByMonths);
		
		JSONObject contYJ = (JSONObject) parser.parse(countByYearJson);
		JSONObject contMJ = (JSONObject) parser.parse(countByMonthsJson);
		
		jsonArr = new JSONArray();
		jsonArr.add(contYJ);
		jsonArr.add(contMJ);
		
		json = new JSONObject();
		json.put("memberAdmin", jsonArr);
		
		return json;
	}

	public JSONObject productAdmin() throws ParseException {
		Map<String, Object> admin = getProductAdminData();
		
		String[] types = {"미거래 상품", "거래 상품", "미거래 삭제 상품"};
		
		long[] productAdminType = (long[])admin.get("totalPieType");
		String productAdminTypeJson = to_json("productAdminType", types, productAdminType);
		
		List<String> categorys = (List<String>)admin.get("category");
		Object[] prodCategorys = {admin.get("inByCategory"), admin.get("tradeByCategory"), admin.get("outByCategory")};
		String productAdminCategoryJson = to_json("productAdminCategory", types, categorys, prodCategorys);
		
		JSONObject pTypeJ = (JSONObject) parser.parse(productAdminTypeJson);
		JSONObject pCatgryJ = (JSONObject) parser.parse(productAdminCategoryJson);
		
		jsonArr = new JSONArray();
		jsonArr.add(pTypeJ);
		jsonArr.add(pCatgryJ);
		
		json = new JSONObject();
		json.put("productAdmin", jsonArr);
		
		return json;
	}

	private String to_json(String type, String[] types, List<String> category, Object[] prodCategorys) {
		String json = String.format("{\"%s\":[{\"type\":[", type);
		for(int i=0; i<types.length; i++) {
			json += "\""+types[i]+"\"";
			if(i!=types.length-1) {json += ", ";}
		}
		json += "]}, {\"category\":[";
		for(int i=0; i<category.size(); i++) {
			json += "\""+category.get(i)+"\"";
			if(i!=category.size()-1) { json += ", "; }
		}
		json += "]}, {\"data\":[";
		for(int i=0; i<prodCategorys.length; i++) {
			List<CountByCategory> prodCategory = (List<CountByCategory>)prodCategorys[i];
			json += "[";
			for(int j=0; j<prodCategory.size(); j++) {
				json += prodCategory.get(j).getCnt();
				if(i!=prodCategory.size()-1) { json += ", "; }
			}
			json += "]";
			if(i!=prodCategorys.length-1) { json += ", "; }
		}
		return json+"]}]}";
	}

	private String to_json(String type, String[] types, long[] prodType) {
		String json = String.format("{\"%s\":[{\"type\":[", type);
		for(int i=0; i<types.length; i++) {
			json += "\""+types[i]+"\"";
			if(i!=types.length-1) {json += ", ";}
		}
		json += "]}, {\"data\":[";
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
			json += "\""+types[t]+"\"";
		}
		json += "]}, {\"data\":[";
		if(counts.length==3) { // year
			for(int c=0; c<counts.length; c++) {
				List<CountByYearVo> count = (List<CountByYearVo>)(counts[c]);
				json += "[";
				for(int sc=0, y=0; sc<memberAdminYears.length; sc++) {
					if(y<count.size() && memberAdminYears[sc]==Integer.parseInt(count.get(y).getYear())) {
						json += count.get(y).getCnt();
						y++;
					}else {
						json += 0;
					}
					if(sc<memberAdminYears.length-1) { json += ", "; }
				}
				json += "]";
				if(c!=0) { json += ", "; }
			}
		}else if(counts.length==2){ // month
			for(int c=0; c<counts.length; c++) {
				List<CountByMonthVo> count = (List<CountByMonthVo>)counts[c];
				json += "[";
				for(int sc=0, s=0; sc<memberAdminYears.length; sc++) {
					json += "[";
					if(0<count.size()) {
						for(int m=1; m<13; m++) {
							if(m!=1) { json += ", "; }
							if(memberAdminYears[sc]==Integer.parseInt(count.get(s).getYear())) {
								if(Integer.parseInt(count.get(s).getMonth())!=m) {
									json += 0;
								}else {
									json += count.get(s).getCnt();
									if(s<count.size()-1) { s++; }
								}
							}else {
								json += 0;
							}
						}
					}else {
						json += "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0";
					}
					json += "]";
					if(sc<memberAdminYears.length-1) { json += ", "; }
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
		for(int i=0, y=Integer.parseInt(memAminYear.get(0)); i<memberAdminYears.length; i++) {
			memberAdminYears[i] = y+i;
		}
		
		List<CountByYearVo> countAllMemberYear = dao.countAllMemberYear();
		
		List<CountByYearVo> countJoinMemberYear = dao.countMemberYear("IN   ");
		List<CountByYearVo> countWithdrawMemberYear = dao.countMemberYear("OUT  ");
		
		List<CountByMonthVo> joinMonths = dao.countMemberMonth("IN   ");
		List<CountByMonthVo> withdrawMonths = dao.countMemberMonth("OUT  ");
		
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
		
		long totalP = dao.countAllTypeProduct("IN");
		long totalTradeP = dao.countAllTypeProduct("TRADE");
		long totalNoTrdRemoveP = dao.countBfTradeRemovedProduct();
		long[] productAdminType = {(totalP-totalTradeP-totalNoTrdRemoveP), totalTradeP, totalNoTrdRemoveP};
		
		List<String> categorys = dao.selectAllCategorys();
		
		List<CountByCategory> inProd = dao.countAllTypeProductByCategory("IN");
		List<CountByCategory> tradeProd = dao.countAllTypeProductByCategory("TRADE");
		List<CountByCategory> outProd = dao.countBfTradeRemovedProductByCategory();
		
		admin.put("totalPieType", productAdminType);
		admin.put("category", categorys);
		admin.put("inByCategory", inProd);
		admin.put("tradeByCategory", tradeProd);
		admin.put("outByCategory", outProd);
		
		return admin;
	}
	
}
