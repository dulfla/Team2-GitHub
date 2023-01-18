package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.vo.ChangeMemberInfoCommand;
import spring.vo.Member;

@Repository
public class MemberDao {
	@Autowired
	private SqlSession sqlSession;
	
	String nameSpace = "mybatis.mapper.member.";
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public Member selectByEmail(String email) {
		System.out.println(email);
		return sqlSession.selectOne(nameSpace+"selectByEmail",email);	
	}
	
	public void insertMember(Member m) {
		sqlSession.insert(nameSpace+"insertMember",m);
	}
	
	public void updateMember(Member updateMember) {
		sqlSession.update(nameSpace+"updateMember",updateMember);
	}
	
	
	public int getNickName(String nickname) {
		return sqlSession.selectOne(nameSpace+"getNickName",nickname);
	}

	public int getEmail(String email) {
		
		return sqlSession.selectOne(nameSpace+"getEmail",email);
	}

	public void updateEmail(Member updateMember) {
		System.out.println(updateMember.getEmail());
		sqlSession.update(nameSpace+"updateEmail",updateMember);
		
	}


	public void updatePassword(Member member) {
		System.out.println();
		sqlSession.update(nameSpace+"updatePassword",member);
	}

import org.apache.ibatis.session.SqlSession;

import spring.vo.CategoryVO;
import spring.vo.Product1VO;
import spring.vo.ProductImageVO;
import spring.vo.ProductVO;

public interface MemberDao {
		
	// 상품 등록
	public void productRegister(ProductVO vo);
	public void productRegister1(Product1VO vo1);
	
	// 사진 등록
	public void imageRegister(ProductImageVO vo);
	
	// 카테고리
	public List<CategoryVO> category();
		
	// 상품 조회
	public ProductVO productDetail(String p_id);
	
	// 이미지 데이터 반환
	public List<ProductImageVO> getImageList(String p_id);
	
	// 상품 수정
	public void productModify(ProductVO vo);
	
	// 상품 이미지 삭제
	public void deleteImage(String p_id);
	
	// 상푸 이미지 수정 업데이트
	public void modifyImage(ProductImageVO vo);

	// 상품 삭제
	public void productDelete(String p_id);
	
	// 상품 이미지 정보 얻기
	public List<ProductImageVO> getImageInfo(String p_id);

}
