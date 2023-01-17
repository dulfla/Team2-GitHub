<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="p-3 mb-3 border-bottom">
	<div class="container">
    	<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
      		<a href="Main" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
        		<img class="bi me-2" width="150" height="60" role="img" alt="그린마켓 로고" src="${path}resources/img/그린마켓2.png">
        		<%-- 로고 비율 최적화 == w:150, h:60 --%>
      		</a>

		    <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
			    <li><a href="#" class="nav-link px-2 link-dark">중고 거래</a></li>
		    	<c:if test="true"> <%-- ${!empty member && member.type=='U'} --%>
				    <li>
				    	<a href="#" class="nav-link px-2 link-dark dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">내 물건</a>
				        <ul class="dropdown-menu text-small">
				            <li><a class="dropdown-item" href="#">상품 등록</a></li>
				            <li><a class="dropdown-item" href="#">상품 관리</a></li>
				        </ul>
				    </li>		    	
		    	</c:if>
		    	<c:if test="true"> <%-- ${!empty member && member.type=='M'} --%>
				    <li>
				    	<a href="#" class="nav-link px-2 link-dark dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">현황 관리</a>
				        <ul class="dropdown-menu text-small">
				            <li><a class="dropdown-item" href="MemberStatus">회원 현황</a></li>
				            <li><a class="dropdown-item" href="ProductStatus">게시물 현황</a></li>
				        </ul>
				    </li>	    	
		    	</c:if>
		    </ul>
	
	      	<form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search" action="#" method="get">
	      		<input type="search" class="form-control" placeholder="검색어 입력..." aria-label="Search" name="search">
	      	</form>
	
	      	<div class="dropdown text-end">
	      		<c:if test="false"> <%-- ${empty member} --%>
				    <button type="button" class="btn btn-outline-dark me-2">로그인</button>
	        		<button type="button" class="btn btn-warning">회원가입</button>
		    	</c:if>
	        	<c:if test="true"> <%-- ${!empty member} --%>
				    <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
			            <img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle">
			        </a>
			        <ul class="dropdown-menu text-small">
			        	<c:if test="true"> <%-- ${member.type=='U'} --%>
			        		<li><a class="dropdown-item" href="" id="chattingRoom">채팅방 보기</a></li> <!-- ${member.email} -->
				            <li><a class="dropdown-item" href="#">판매목록</a></li>
				            <li><a class="dropdown-item" href="#">구매목록</a></li>
				            <li><a class="dropdown-item" href="#">정보수정</a></li>
				            <li><hr class="dropdown-divider"></li>
			            </c:if>
			            <li><a class="dropdown-item" href="#">로그아웃</a></li>
			        </ul>
		    	</c:if>
	     	</div>
	  	</div>
   	</div>
</header>