package spring.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import spring.vo.CategoryAdminVo;
import spring.vo.CategoryVO;
import spring.vo.CountByCategory;
import spring.vo.CountByMonthVo;
import spring.vo.CountByYearVo;

public class AdminDao {

	private SqlSession sqlSession;
	public AdminDao(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<String> memberAdminYears() { // 가입 기록이나 탈퇴 기록이 있는 년도
		return sqlSession.selectList("mybatis.mapper.admin.selectMemberAdminYears");
	}

	public List<CountByYearVo> countAllMemberYear() { // 년도별 누적 회원수
		return sqlSession.selectList("mybatis.mapper.admin.countAllMemberYear");
	}

	public List<CountByYearVo> countMemberYear(String type) { // 년도별 가입/탈퇴 건수
		return sqlSession.selectList("mybatis.mapper.admin.countMemberYear", type);
	}
	
	public List<CountByMonthVo> countMemberMonth(String type) { // 월별 가입/탈퇴 건수
		return sqlSession.selectList("mybatis.mapper.admin.countMemberMonth", type);
	}

	public Long countAllTypeProduct(String type) { // 전체 상품 등록, 삭제, 거래 건수
		return sqlSession.selectOne("mybatis.mapper.admin.countAllTypeProduct", type);
	}

	public Long countBfTradeRemovedProduct() { // 전체 상품 미거래 삭제 건수
		return sqlSession.selectOne("mybatis.mapper.admin.countBfTradeRemovedProduct");
	}

	public List<CountByCategory> countAllTypeProductByCategory(String type) { // 카테고리별 상품 등록, 삭제, 거래 건수
		return sqlSession.selectList("mybatis.mapper.admin.countAllTypeProductByCategory", type);
	}

	public List<CountByCategory> countBfTradeRemovedProductByCategory() { // 카테고리별 상품 미거래 삭제 건수
		return sqlSession.selectList("mybatis.mapper.admin.countBfTradeRemovedProductByCategory");
	}

	public List<String> selectAllCategorys() {
		return sqlSession.selectList("mybatis.mapper.admin.selectAllCategory");
	}

	public List<CategoryVO> getAllCategory() {
		return sqlSession.selectList("mybatis.mapper.admin.selectAllCategorys");
	}

	public String originFileName(String c) {
		return sqlSession.selectOne("mybatis.mapper.admin.selectCategoryFileName", c);
	}

	public void updateIcon(CategoryAdminVo cvo) {
		sqlSession.selectOne("mybatis.mapper.admin.updateCategoryIcon", cvo);
	}

	public int checkNewCategoryTitle(String c) {
		return sqlSession.selectOne("mybatis.mapper.admin.checkNewCategoryTitle", c);
	}

	public void updateCategory(Map<String, String> map) {
		sqlSession.selectOne("mybatis.mapper.admin.updateCategory", map);
	}

	public void updateProduct(Map<String, String> map) {
		sqlSession.selectOne("mybatis.mapper.admin.updateCategoryInProduct", map);
	}

	public void addNewCategory(CategoryAdminVo cvo) {
		sqlSession.selectOne("mybatis.mapper.admin.insertNewCategory", cvo);
	}
}
